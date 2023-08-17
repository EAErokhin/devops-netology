resource "yandex_compute_instance" "vm" {
  depends_on = [yandex_compute_instance.web]
  for_each = var.vms

  name       = each.value.vm_name
  platform_id = "standard-v2"
  zone       = "ru-central1-a"
  resources {
    cores      = each.value.cores
    memory     = each.value.memory
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-2004-lts.image_id
      size     = each.value.disk
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  scheduling_policy {
    preemptible = true
  }


  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${local.ssh-keys}"
  }
}

variable "vms" {
  type = map(object({
    vm_name = string
    cores     = number
    memory    = number
    disk      = number
  }))
  default = {
    main    = { vm_name = "main", cores = 2, memory = 2, disk = 5 }
    replica = { vm_name = "replica", cores = 4, memory = 4, disk = 10 }
  }
}