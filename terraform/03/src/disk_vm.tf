resource "yandex_compute_disk" "disk" {
  count = 3
  name  = "my-disk-${count.index}"
  size  = 1
}
resource "yandex_compute_instance" "disk_vm" {
    count = 1
    name = "storage"
    platform_id = "standard-v1"
    resources {
      cores         = 2
      memory        = 1
      core_fraction = 5
    }
    boot_disk {
      initialize_params {
        image_id = data.yandex_compute_image.ubuntu-2004-lts.image_id
    }
  }
  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.disk
    content {
      disk_id = secondary_disk.value.id
      mode      = "READ_WRITE"
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    security_group_ids = [yandex_vpc_security_group.example.id]    
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${local.ssh-keys}"
  }
}