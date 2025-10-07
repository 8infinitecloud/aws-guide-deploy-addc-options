<powershell>
# Set execution policy
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Force

# Configure DNS servers
$dnsServers = @(${join(", ", [for ip in dns_servers : "\"${ip}\""])})
if ($dnsServers.Count -gt 0) {
    $adapter = Get-NetAdapter | Where-Object {$_.Status -eq "Up"} | Select-Object -First 1
    Set-DnsClientServerAddress -InterfaceIndex $adapter.InterfaceIndex -ServerAddresses $dnsServers
}

# Set computer name
Rename-Computer -NewName "${client_name}" -Force

# Configure Windows features
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -All -NoRestart
Install-WindowsFeature -Name RSAT-AD-Tools -IncludeAllSubFeature

# Configure CloudWatch Agent
$config = @"
{
    "logs": {
        "logs_collected": {
            "windows_events": {
                "collect_list": [
                    {
                        "event_name": "System",
                        "event_levels": ["ERROR", "WARNING"],
                        "log_group_name": "/aws/ec2/domain-clients",
                        "log_stream_name": "{instance_id}/System"
                    },
                    {
                        "event_name": "Application",
                        "event_levels": ["ERROR", "WARNING"],
                        "log_group_name": "/aws/ec2/domain-clients",
                        "log_stream_name": "{instance_id}/Application"
                    }
                ]
            }
        }
    }
}
"@

$config | Out-File -FilePath "C:\Program Files\Amazon\AmazonCloudWatchAgent\config.json" -Encoding UTF8

# Start CloudWatch Agent
& "C:\Program Files\Amazon\AmazonCloudWatchAgent\amazon-cloudwatch-agent-ctl.ps1" -a fetch-config -m ec2 -c file:"C:\Program Files\Amazon\AmazonCloudWatchAgent\config.json" -s

# Wait for DNS resolution
do {
    Start-Sleep -Seconds 30
    $dnsTest = Resolve-DnsName -Name "${domain_name}" -ErrorAction SilentlyContinue
} while (-not $dnsTest)

# Join domain
$securePassword = ConvertTo-SecureString "${admin_password}" -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential("${admin_username}", $securePassword)

try {
    Add-Computer -DomainName "${domain_name}" -Credential $credential -Force -Restart
    Write-Output "Successfully joined domain ${domain_name}"
} catch {
    Write-Error "Failed to join domain: $($_.Exception.Message)"
    # Log error for troubleshooting
    $_ | Out-File -FilePath "C:\domain-join-error.log" -Append
}
</powershell>
