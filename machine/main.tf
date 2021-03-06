
data "vsphere_network" "network" {
  name          = "${var.network}"
  datacenter_id = "${var.datacenter_id}"
}

data "vsphere_virtual_machine" "template" {
  name          = "${var.template}"
  datacenter_id = "${var.datacenter_id}"
}

resource "vsphere_virtual_machine" "vm" {
  count            = "${var.instance_count}"
  name             = "${var.name}-${count.index}"
  resource_pool_id = "${var.resource_pool_id}"
  datastore_id     = "${var.datastore_id}"
  num_cpus         = "${var.num_cpu}"
  memory           = "${var.memory}"
  boot_delay       = "${var.boot_delay}"
  guest_id         = "${data.vsphere_virtual_machine.template.guest_id}"
  folder           = "${var.folder}"
  enable_disk_uuid = "true"

  wait_for_guest_net_timeout  = "0"
  wait_for_guest_net_routable = "false"

  network_interface {
    network_id     = "${data.vsphere_network.network.id}"
    use_static_mac = "true"
    mac_address    = "${var.mac_addressess[count.index]}"
  }

  disk {
    label            = "disk0"
    size             = "${var.disk_size}"
    thin_provisioned = "${data.vsphere_virtual_machine.template.disks.0.thin_provisioned}"
    datastore_id     = "${var.datastore_id}"
  }

  clone {
    template_uuid = "${data.vsphere_virtual_machine.template.id}"
   }

  vapp {
    properties = {
      "guestinfo.ignition.config.data"          = "${var.ignition}"
      "guestinfo.ignition.config.data.encoding" = "base64"
    }
  }
}
