output "info_servers_web" {
  value = [
    for i in yandex_compute_instance.platform :
    {
      name = i.name
      id   = i.id
      fqdn = i.fqdn
    }
  ]
  description = "Info about Web servers"
}

output "info_servers_db" {
  value = [
    for i in yandex_compute_instance.vm_for_each :
    {
      name = i.name
      id   = i.id
      fqdn = i.fqdn
    }
  ]
  description = "Info about DB servers"
}

output "info_server_storage" {
  value = {
    name = yandex_compute_instance.storage.name
    id   = yandex_compute_instance.storage.id
    fqdn = yandex_compute_instance.storage.fqdn
  }
  description = "Info about Storage server"
}