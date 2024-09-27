data "vkcs_compute_flavor" "compute" {
  name = var.compute_flavor
}

data "vkcs_images_image" "compute" {
  name = var.image_name
}

resource "vkcs_compute_instance" "vm1" {
  name                    = "ITHUBterraforubuntu1-minaev"
  flavor_id               = data.vkcs_compute_flavor.compute.id
  key_pair                = var.key_pair_name
  security_groups         = ["default","ssh", "security_group_minaev"]
  availability_zone       = "MS1"

  block_device {
    uuid                  = data.vkcs_images_image.compute.id
    source_type           = "image"
    destination_type      = "volume"
    volume_type           = "ceph-ssd"
    volume_size           = 10
    boot_index            = 0
    delete_on_termination = true
  }

  network {
    uuid = vkcs_networking_network.minaev.id
    fixed_ip_v4 = "192.168.254.100"
  }

  user_data = <<-EOF
    packages:
	  - nginx
    EOF

  depends_on = [
    vkcs_networking_network.minaev,
    vkcs_networking_subnet.minaev
  ]
}

resource "vkcs_compute_instance" "vm2" {
  name                    = "ITHUBterraforubuntu2-minaev"
  flavor_id               = data.vkcs_compute_flavor.compute.id
  key_pair                = var.key_pair_name
  security_groups         = ["default","ssh", "security_group_minaev"]
  availability_zone       = "GZ1"

  block_device {
    uuid                  = data.vkcs_images_image.compute.id
    source_type           = "image"
    destination_type      = "volume"
    volume_type           = "ceph-ssd"
    volume_size           = 10
    boot_index            = 0
    delete_on_termination = true
  }

  network {
    uuid = vkcs_networking_network.minaev.id
    fixed_ip_v4 = "192.168.254.200"
  }

  user_data = <<-EOF
    packages:
	  - nginx
    EOF

  depends_on = [
    vkcs_networking_network.minaev,
    vkcs_networking_subnet.minaev
  ]
}

