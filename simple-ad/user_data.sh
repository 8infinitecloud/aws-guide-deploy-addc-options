#!/bin/bash
yum update -y
yum install -y sssd realmd oddjob oddjob-mkhomedir adcli samba-common samba-common-tools krb5-workstation openldap-clients policycoreutils-python

# Configure DNS
echo "nameserver ${dns_ip_1}" > /etc/resolv.conf
echo "nameserver ${dns_ip_2}" >> /etc/resolv.conf
echo "search ${domain_name}" >> /etc/resolv.conf

# Join domain
echo "${admin_password}" | realm join --user=Administrator ${domain_name}

# Configure SSSD
systemctl enable sssd
systemctl start sssd

# Allow domain users to login
realm permit --all
