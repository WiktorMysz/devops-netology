resource "yandex_compute_instance" "node06" {
  name                      = "node06"
  zone                      = var.zones[2]
  hostname                  = "runner.myshelov.site"
  allow_stopping_for_update = true

  resources {
    cores  = 4
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id    = "${var.work-instans}"
      name        = "root-node06"
      type        = "network-nvme"
      size        = "10"
    }
  }

  network_interface {
    subnet_id  = "${yandex_vpc_subnet.subnet[2].id}"
    nat        = true
  }

  metadata = {
    user-data           = "${file("meta.txt")}"
#    serial-port-enable = 1
  }
}