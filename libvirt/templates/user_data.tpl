#cloud-config
# vim: syntax=yaml
hostname: ${hostname}
manage_etc_hosts: true
users:
  - name: terraform
    sudo: ALL=(ALL) NOPASSWD:ALL
    ssh_authorized_keys:
      - ${authorized_keys}
ssh_pwauth: true
disable_root: false
chpasswd:
  list: |
    terraform:terraform
    root:toor
  expire: false
growpart:
  mode: auto
  devices: ['/']