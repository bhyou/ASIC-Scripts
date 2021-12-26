##########################################################################
# Copyright (C) 2021 Sangfor Ltd. All rights reserved.
# File Name   : dbGet.tcl
# Author      : bhyou
# mail        : bhyou@foxmail.com
# Created Time: Sun 26 Dec 2021 03:06:26 PM CST
#########################################################################

# replace_cells DEL4XPG DEL4HD; 
# means that the DEL4XPG is replaced by DEL4HD.    
proc replace_cells {old_cell new_cell} {
    foreach_in_collection iCell [all_instances -hierarchical [get_lib_cells ${old_cell}]] {
    	set cellName [get_property ${iCell} hierarchical_name]
    	puts "$cellName"
    	ecoChangeCell -inst $cellName -cell ${new_cell}
	}
}

# change_route_rule M7; # means changing the routing rule of M7
proc change_route_rule {layer} {
	foreach iNet  [dbGet top.nets.wires.layer.name ${layer} -p2] {
		set netName [dbGet $iNet.net.name]
		setAttribute -net $netName -non_default_rule  ndr_rule
		selectNet $netName
		globaldetailrotue  -select
	}
}

# list all unplaced instances
dbGet [dbGet -p top.insts.pStatus unplaced].name

# list all placed instances
dbGet [dbGet -p top.insts.pStatus placed].name

# list all fixed instances
dbGet [dbGet -p top.insts.pStatus fixed].name
select_obj [dbGet -p top.insts.pStatus fixed]

# list the layer used by the block io port
dbGet top.terms.pins.allShapers.layer.name

# list all non non_default_rule (NDR)
dbGet head.rules.name
report_routing_rules 

# list the routing rule of a net
dbGet [dbGet -p top.nets.name ${netName}].rule.name

# list all types of cell
dbGet -u top.insts.cell.name

# get the coordinates of the polygon routing blockage
dbGet top.fplan.rBlkgs.shapers.ploy