terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.139.0"
    }
  }
}

provider "yandex" {
  token     = "t1.9euelZqOx5bIxpORipyWls7Ol8-emO3rnpWazJeRms-Mx8nIiYmNycnHlY7l8_c-KHRA-e9_Twdg_N3z935WcUD5739PB2D8zef1656VmsiVmI3Gypebj8eTzpOSk8yc7_zF656VmsiVmI3Gypebj8eTzpOSk8yc.L2-xcupygxyDbzCpuECs0qahjH2conXsrBqT4Vk5prTvPs3rL881c6fRv1AECzLQ7Y-rzJ95ayiqGmKLFDacBw"
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

}
