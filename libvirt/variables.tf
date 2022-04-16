variable "libvirt_storage_pool" {
  description = "default storage pool"
  type =  string
  default     = "KVM"
}

variable "ubuntu_img_url" {
  description = "ubuntu cloud init image 20.04 focal"
  type = string
  default =  "http://127.0.0.1:8000/focal-server-cloudimg-amd64.img"
# default     = "http://cloud-images-archive.ubuntu.com/releases/focal/release-20200423/ubuntu-20.04-server-cloudimg-amd64.img"
}

variable "interface" {
  description = "default vm interface"
  type = string
  default = "ens3"
}

variable "ips" {
  description = "available IPv4 addressess"
  type = list
  default = ["192.168.124.10", "192.168.124.11"] 
}

variable "network" {
  description = "network name"
  type = string
  default = "infra"
}

variable "domains" {
  description = "name of hosts"
  type = list
  default = ["vm1", "vm2"]
}

variable "memory" {
  description = "vm default memory"
  type =  string
  default = "2048"
}

variable "vcpu" {
  description = "vm default number of cpus"
  type = number
  default = 2
}

variable "flavors" {
  description = "gnu/linux flavors"
  type = list
  default = ["ubuntu"]
}
