// Username and Password on the vSphere server.
vsphere_user = ""
vsphere_password = ""
vsphere_server = ""

project_name = ""
cluster_id = ""

base_domain = ""

// Domain of the cluster. This should be "${cluster_id}.${base_domain}".
cluster_domain = ""

target_folder = ""

resource_pool = ""

// Name of the vSphere data center. 
vsphere_datacenter = ""
datacenter_id = ""

vm_template = ""
vm_network = ""

datastore_cluster = ""
datastore = ""

///////////
// Count
///////////
control_plane_count = 1
compute_count = 1
storage_count = 0

///////////
// Memory
///////////
bootstrap_memory = "16384"
control_plane_memory = "24000"
compute_memory = "16384"

///////////
// Ignition URL
///////////
bootstrap_ignition_url = ""
control_plane_ignition = ""
compute_ignition = ""

///////////
// CPU
///////////
bootstrap_num_cpu = "4"
control_plane_num_cpu = "16"
compute_num_cpu = "8"

///////////
// Disk Size
///////////
bootstrap_disk_size = "100"
control_plane_disk_size = "150"
compute_disk_size = "100"

///////////
// Mac Addresses
///////////
bootstrap_mac_address = [""]
control_plane_mac_addresses = [""]
compute_mac_addresses = [""]
storage_mac_addresses = [""]

///////////
// IP Addresses
///////////
bootstrap_ip = ""
control_plane_ips = [""]
compute_ips = [""]
storage_ips = [""]





///////////
// Default values (no need to touch in this setup)
///////////

// will modify if needed for Static IP

gw               = "172.18.15.72"
dns1             = "172.18.0.10"
mask             = "27"

machine_cidr = "172.18.15.0/27"
bootstrap_cidr = "172.18.15.0/24"
bootstrap_offset = "73"

control_plane_cidr = "172.18.15.0/24"
control_plane_offset = "67"

compute_cidr = "172.18.15.0/24"
compute_offset = "70"


