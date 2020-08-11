provider "vsphere" {
  user                 = "${var.vsphere_user}"
  password             = "${var.vsphere_password}"
  vsphere_server       = "${var.vsphere_server}"
  version = "< 1.16.0"
  allow_unverified_ssl = true
}
data "vsphere_datacenter" "dc" {
  name = "${var.datacenter_id}"
}
data "vsphere_compute_cluster" "cluster" {
  name          = "${var.datastore_cluster}" 
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}
data "vsphere_datastore" "datastore" {
  name          = "${var.datastore}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}
data "vsphere_resource_pool" "pool" {
  name          = "/${var.vsphere_datacenter}/host/${var.datastore_cluster}/Resources/${var.resource_pool}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

module "bootstrap" {
  source = "./machine"
  name             = "${var.project_name}-bootstrap"
  instance_count   = "1"
  boot_delay       =  5000
  ignition         = "${var.bootstrap_ignition_url}"
  resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
  datastore_id     = "${data.vsphere_datastore.datastore.id}"
  folder           = "${var.target_folder}" 
  network          = "${var.vm_network}"
  datacenter_id    = "${data.vsphere_datacenter.dc.id}"
  template         = "${var.vm_template}"
  cluster_domain   = "${var.cluster_domain}"
  ipam             = "${var.ipam}"
  ipam_token       = "${var.ipam_token}"
  ip_addresses     = ["${compact(list(var.bootstrap_ip))}"]
  mac_addressess   = "${var.bootstrap_mac_address}"
  cidr             = "${var.bootstrap_cidr}"
  offset           = "${var.bootstrap_offset}"
  machine_cidr     = "${var.machine_cidr}"
  gw               = "${var.gw}"
  dns1             = "${var.dns1}"
  mask             = "${var.mask}"
  memory           = "${var.bootstrap_memory}"
  num_cpu          = "${var.bootstrap_num_cpu}"
  disk_size        = "${var.bootstrap_disk_size}"
  is_storage       = false
}
module "control_plane" {
  source = "./machine"

  name             = "${var.project_name}-control-plane"
  instance_count   = "${var.control_plane_count}"
  boot_delay       =  10000
  ignition         = "${var.control_plane_ignition}"
  resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
  datastore_id     = "${data.vsphere_datastore.datastore.id}"
  folder           = "${var.target_folder}"
  network          = "${var.vm_network}"
  datacenter_id    = "${data.vsphere_datacenter.dc.id}"
  template         = "${var.vm_template}"
  cluster_domain   = "${var.cluster_domain}"
  ipam             = "${var.ipam}"
  ipam_token       = "${var.ipam_token}"
  ip_addresses     = ["${var.control_plane_ips}"]
  mac_addressess   = "${var.control_plane_mac_addresses}"
  cidr             = "${var.control_plane_cidr}"
  offset           = "${var.control_plane_offset}"
  machine_cidr     = "${var.machine_cidr}"
  gw               = "${var.gw}"
  dns1             = "${var.dns1}"
  mask             = "${var.mask}"
  memory           = "${var.control_plane_memory}"
  num_cpu          = "${var.control_plane_num_cpu}"
  disk_size        = "${var.control_plane_disk_size}"
  is_storage       = false
}

module "compute" {
  source = "./machine"

  name             = "${var.project_name}-compute"
  instance_count   = "${var.compute_count}"
  ignition         = "${var.compute_ignition}"
  boot_delay       =  15000
  resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
  datastore_id     = "${data.vsphere_datastore.datastore.id}"
  folder           = "${var.target_folder}"
  network          = "${var.vm_network}"
  datacenter_id    = "${data.vsphere_datacenter.dc.id}"
  template         = "${var.vm_template}"
  cluster_domain   = "${var.cluster_domain}"
  ipam             = "${var.ipam}"
  ipam_token       = "${var.ipam_token}"
  ip_addresses     = ["${var.compute_ips}"]
  mac_addressess   = "${var.compute_mac_addresses}"
  cidr             = "${var.compute_cidr}"
  offset           = "${var.compute_offset}"
  machine_cidr     = "${var.machine_cidr}"
  gw               = "${var.gw}"
  dns1             = "${var.dns1}"
  mask             = "${var.mask}"
  memory           = "${var.compute_memory}"  
  num_cpu          = "${var.compute_num_cpu}"
  disk_size        = "${var.compute_disk_size}"
  is_storage       = false
}

module "storage" {
  source = "./machine"

  name             = "${var.project_name}-storage"
  instance_count   = "${var.storage_count}"
  boot_delay       =  15000
  ignition         = "${var.compute_ignition}"
  resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
  datastore_id     = "${data.vsphere_datastore.datastore.id}"
  folder           = "${var.target_folder}"
  network          = "${var.vm_network}"
  datacenter_id    = "${data.vsphere_datacenter.dc.id}"
  template         = "${var.vm_template}"
  cluster_domain   = "${var.cluster_domain}"
  ipam             = "${var.ipam}"
  ipam_token       = "${var.ipam_token}"
  ip_addresses     = ["${var.storage_ips}"]
  mac_addressess   = "${var.storage_mac_addresses}"
  cidr             = "${var.compute_cidr}"
  offset           = "${var.compute_offset}"
  machine_cidr     = "${var.machine_cidr}"
  gw               = "${var.gw}"
  dns1             = "${var.dns1}"
  mask             = "${var.mask}"
  memory           = "16384"  
  num_cpu          = "4"
  disk_size        = "200"
  is_storage       = true
}