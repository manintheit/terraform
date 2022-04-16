ethernets:
    ${interface}:
        addresses: 
        - ${ipaddr}/24
        dhcp4: false
        gateway4: 192.168.124.1
        nameservers:
            addresses: 
            - 192.168.124.1
version: 2