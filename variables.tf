variable "token" {
  type        = string
  description = "OAuth-token"
}

variable "cloud_id" {
  type        = string
  description = "Yandex Cloud ID"
}

variable "folder_id" {
  type        = string
  description = "Yandex Folder ID"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-d"
  description = "https://yandex.ru"
}

variable "default_cidr" {
  type        = list(string)
  default     = ["10.130.0.0/24"]
  description = "https://yandex.ru"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}

variable "ubuntu" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "OS Image family"
}

### VM Resources
variable "vm_resources_list" {
  type = list(object({
    vm_name       = string
    cpu           = number
    ram           = number
    disk          = number
    core_fraction = number
  }))
  default = [
    {
      vm_name       = "db-vm-1"
      cpu           = 2
      ram           = 1
      disk          = 5
      core_fraction = 20 # Исправлено: 20% вместо 5%
    },
    {
      vm_name       = "db-vm-2"
      cpu           = 4
      ram           = 2
      disk          = 10
      core_fraction = 20 # Исправлено: 20% вместо 5%
    }
  ]
  description = "List of dictionaries with VM resources for DB"
}

variable "vms_ssh_root_key" {
  type = map(any)
  default = {
    serial-port-enable = 1
    ssh-keys           = "~/Downloads/ssh-key-1788261541539/ssh-key-1788261541539.pub"
  }
}