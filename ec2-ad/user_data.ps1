<powershell>
# Install AD DS Role
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools

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
                        "log_group_name": "/aws/ec2/domain-controllers",
                        "log_stream_name": "{instance_id}/System"
                    },
                    {
                        "event_name": "Directory Service",
                        "event_levels": ["ERROR", "WARNING", "INFORMATION"],
                        "log_group_name": "/aws/ec2/domain-controllers",
                        "log_stream_name": "{instance_id}/DirectoryService"
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

%{ if is_first_dc }
# Create new forest (First DC)
$SecurePassword = ConvertTo-SecureString "${admin_password}" -AsPlainText -Force
$SafeModePassword = ConvertTo-SecureString "${safe_mode_password}" -AsPlainText -Force

Install-ADDSForest `
    -DomainName "${domain_name}" `
    -DomainNetbiosName "${domain_netbios_name}" `
    -SafeModeAdministratorPassword $SafeModePassword `
    -InstallDns `
    -Force

# Restart after forest creation
Restart-Computer -Force
%{ else }
# Join existing domain (Additional DC)
$SecurePassword = ConvertTo-SecureString "${admin_password}" -AsPlainText -Force
$SafeModePassword = ConvertTo-SecureString "${safe_mode_password}" -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential("${domain_netbios_name}\Administrator", $SecurePassword)

# Wait for first DC to be available
do {
    Start-Sleep -Seconds 30
    $ping = Test-NetConnection -ComputerName "${first_dc_ip}" -Port 389 -InformationLevel Quiet
} while (-not $ping)

Install-ADDSDomainController `
    -DomainName "${domain_name}" `
    -Credential $Credential `
    -SafeModeAdministratorPassword $SafeModePassword `
    -InstallDns `
    -Force

# Restart after domain join
Restart-Computer -Force
%{ endif }
</powershell>
