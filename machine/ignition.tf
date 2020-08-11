# locals {
#   mask = "${var.mask}"
#   gw = "${var.gw}"

#   ignition_encoded = "data:text/plain;charset=utf-8;base64,${base64encode(var.ignition)}"
# }

# data "ignition_file" "hostname" {
#   count = "${var.instance_count}"

#   filesystem = "root"
#   path       = "/etc/hostname"
#   mode       = "420"

#   content {
#     content = "${var.name}-${count.index}"
#   }
# }

# data "ignition_file" "static_ip" {
#   count = "${var.instance_count}"

#   filesystem = "root"
#   path       = "/etc/sysconfig/network-scripts/ifcfg-ens192"
#   mode       = "420"

#   content {
#     content = <<EOF
# TYPE=Ethernet
# NAME=ens192
# DEVICE=ens192
# IPADDR=${cidrhost(var.cidr, 1 + var.offset + count.index)}
# BOOTPROTO=none
# ONBOOT=yes
# PREFIX=${local.mask}
# GATEWAY=${local.gw}
# DOMAIN=${var.cluster_domain}
# DNS1=${var.dns1}
# EOF
#   }
# }

# data "ignition_systemd_unit" "restart" {
#   count = "${var.instance_count}"

#   name = "restart.service"

#   content = <<EOF
# [Unit]
# ConditionFirstBoot=yes
# [Service]
# Type=idle
# ExecStart=/sbin/reboot
# [Install]
# WantedBy=multi-user.target
# EOF
# }

# data "ignition_config" "ign" {
#   count = "${var.instance_count}"

#   append {
#     source = "${var.ignition_url != "" ? var.ignition_url : local.ignition_encoded}"
#   }

#    systemd = [
#     "${data.ignition_systemd_unit.restart.*.id[count.index]}",
#   ]

#   files = [
#     "${data.ignition_file.hostname.*.id[count.index]}",
#     "${data.ignition_file.static_ip.*.id[count.index]}",
#   ]
# }
