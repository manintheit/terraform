# required terraform version
terraform {
  required_providers {
    libvirt = {
      version = ">= 0.6.14"
      source = "dmacvicar/libvirt"
    }
  }
  # backend "local" {
  #   path = "./tfstate/terraform.tfstate"
  # }
}
# libvirt on local system
provider "libvirt" {
  uri = "qemu:///system"
}
