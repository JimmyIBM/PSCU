//////
// vSphere variables
//////

variable "vsphere_server" {
  type        = "string"
  description = "This is the vSphere server for the environment."
}

variable "vsphere_user" {
  type        = "string"
  description = "vSphere server user for the environment."
}

variable "vsphere_password" {
  type        = "string"
  description = "vSphere server password"
}

variable "vsphere_datacenter" {
  type        = "string"
  description = "This is the name of the vSphere data center."
}

variable "datacenter_id" {
  type        = "string"
  description = "This is the name of the vSphere data center."
}

variable "datastore_cluster" {
  type        = "string"
  description = "This is the name of the vSphere data center."
}

variable "resource_pool" {
  type        = "string"
  description = "This is the name of the vSphere resource  pool id."
}

variable "datastore" {
  type        = "string"
  description = "This is the name of the vSphere data store."
}

variable "vm_template" {
  type        = "string"
  description = "This is the name of the VM template to clone."
}

variable "vm_network" {
  type        = "string"
  description = "This is the name of the publicly accessible network for cluster ingress and access."
  default     = "VM Network"
}

variable "ipam" {
  type        = "string"
  description = "The IPAM server to use for IP management."
  default     = ""
}

variable "ipam_token" {
  type        = "string"
  description = "The IPAM token to use for requests."
  default     = ""
}

//////
// vSphere Target folder and Project Name
//////

variable "target_folder" {
  type        = "string"
  description = "This is the folder in which you want your files to be created with respect to the datacenter"
}
variable "project_name" {
  type = "string"
}

/////////
// OpenShift cluster variables
/////////

variable "cluster_id" {
  type        = "string"
  description = "This cluster id must be of max length 27 and must have only alphanumeric or hyphen characters."
}

variable "base_domain" {
  type        = "string"
  description = "The base DNS zone to add the sub zone to."
}

variable "cluster_domain" {
  type        = "string"
  description = "The base DNS zone to add the sub zone to."
}

variable "machine_cidr" {
  type = "string"
}

/////////
// Bootstrap machine variables
/////////

variable "bootstrap_complete" {
  type    = "string"
  default = "false"
}

variable "bootstrap_ignition_url" {
  type = "string"
}

variable "bootstrap_ip" {
  type    = "string"
  default = ""
}
variable "bootstrap_mac_address" {
  type    = "list"
  default =  []
}

variable "bootstrap_memory" {
  type   = "string"
}
variable "bootstrap_num_cpu" {
  type   = "string"
}
variable "bootstrap_disk_size" {
  type  = "string"
}
///////////
// Control Plane machine variables
///////////

variable "control_plane_count" {
  type    = "string"
  default = "3"
}

variable "control_plane_ignition" {
  type = "string"
}

variable "control_plane_ips" {
  type    = "list"
  default = []
}
variable "control_plane_mac_addresses" {
  type    = "list"
  default = []
}
variable "control_plane_memory" {
  type   = "string"
}
variable "control_plane_num_cpu" {
  type   = "string"
}
variable "control_plane_disk_size" {
  type  = "string"
}
//////////
// Compute machine variables
//////////

variable "compute_count" {
  type    = "string"
  default = "3"
}

variable "compute_ignition" {
  type = "string"
}

variable "compute_ips" {
  type    = "list"
  default = []
}

variable "compute_mac_addresses" {
  type    = "list"
  default = []  
}
variable "compute_memory" {
  type   = "string"
}
variable "compute_num_cpu" {
  type   = "string"
}
variable "compute_disk_size" {
  type  = "string"
}

///////////
// Control Plane machine variables
///////////

variable "storage_count" {
  type    = "string"
  default = "3"
}

variable "storage_ips" {
  type    = "list"
  default = []
}
variable "storage_mac_addresses" {
  type    = "list"
  default = []
}
///////////
// Non Static IP configs
///////////

variable "bootstrap_cidr"{
  type = "string"
}

variable "compute_cidr"{
  type = "string"
}

variable "control_plane_cidr"{
  type = "string"
}

variable "bootstrap_offset"{
  type = "string"
}

variable "compute_offset"{
  type = "string"
}

variable "control_plane_offset"{
  type = "string"
}

variable "mask" {
  type = "string"
}

variable "gw" {
  type = "string"
}

variable "dns1" {
  type = "string"
}

variable "is_storage" {
  default = false
}