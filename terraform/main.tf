terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.139.0"
    }
  }
}

provider "yandex" {
  token     = "t1.9euelZrLkpWYiciaz5TNnZadiZnJkO3rnpWazJeRms-Mx8nIiYmNycnHlY7l8_d3UnlA-e9EYS4m_t3z9zcBd0D570RhLib-zef1656Vms6Nz5vJmIrKm52azpmPi8ec7_zF656Vms6Nz5vJmIrKm52azpmPi8ec.tVotiqDcSqBXVuZ1FYqQ853L4USyz_f29GP7OVwiJ6UwLFqahVaYmE9xXlOWVpVJoEBh3JSXc88R_4k_HoSJCw"
  cloud_id  = "b1guukrlolhh89d8t696"
  folder_id = "b1gctg2bhvuagrakii2l"
  zone      = "ru-central1-d"
}
resource "yandex_compute_instance" "vm" {
  name = "terraform1"
  platform_id = "standard-v3"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    disk_type = "network-hdd"
    auto_delete = true
    initialize_params {
      image_id = "fd8vmcue7aajpmeo39kk"
      size     = 10
    }
  }
  network_interface {
    subnet_id = "fl896vf7uql0nbq510ll"
    nat = true
  }
 
  metadata = {
    user-data = file("${path.module}/cloud_config.yaml")
    ssh-keys = file("${path.module}/ssh-keys.yaml")
  }
 output "instance_ip" {
  value = yandex_compute_instance.vm[0].network_interface[0].nat_ip_address
  }
}
