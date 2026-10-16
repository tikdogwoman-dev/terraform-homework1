
data "yandex_vpc_network" "develop" {
  name = "default"
}


data "yandex_vpc_subnet" "develop" {
  name = "default-ru-central1-d"
}


data "yandex_compute_image" "ubuntu" {
  family = var.ubuntu
}