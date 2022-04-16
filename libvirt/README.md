## VM provisioning on Libvirt with Terraform

- Do not forget to update the image url

```hcl
variable "ubuntu_img_url" {
  description = "ubuntu cloud init image 20.04 focal"
  type = string
  default =  "http://127.0.0.1:8000/focal-server-cloudimg-amd64.img"
# default     = "http://cloud-images-archive.ubuntu.com/releases/focal/release-20200423/ubuntu-20.04-server-cloudimg-amd64.img"
}
```

- Do not forget to update the network name
```hcl
variable "network" {
  description = "network name"
  type = string
  default = "infra"
}
```
- Do not forget to update interface name if different.
```hcl
variable "interface" {
  description = "default vm interface"
  type = string
  default = "ens3"
}
```
- Do not forget to update storageg pool
```hcl
variable "libvirt_storage_pool" {
  description = "default storage pool"
  type =  string
  default     = "KVM"
}
```