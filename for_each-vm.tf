resource "yandex_compute_instance" "vm_for_each" {
  platform_id = "standard-v3"
  for_each = {
    for index, vm in var.vm_resources_list :
    vm.vm_name => vm
  }

  name = "${each.value.vm_name}-${terraform.workspace}"

  resources {
    cores         = each.value.cpu
    memory        = each.value.ram
    core_fraction = each.value.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = each.value.disk
      type     = "network-ssd" # Исправлено: переключили на SSD, чтобы обойти лимит HDD
    }
  }

  scheduling_policy {
    preemptible = true
  }

  network_interface {
    subnet_id          = data.yandex_vpc_subnet.develop.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  metadata = {
    serial-port-enable = local.serial-port
    ssh-keys           = "ubuntu:${local.ssh-keys}"
  }
}