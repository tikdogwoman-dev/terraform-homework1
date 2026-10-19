resource "yandex_compute_instance" "platform" {
  count       = 2
   name        = "web-${terraform.workspace}-${count.index + 1}"
  platform_id = "standard-v3"

  resources {
    cores         = 2
    memory        = 1
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
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