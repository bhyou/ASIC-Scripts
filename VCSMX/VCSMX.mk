##########################################################################
# Copyright (C) 2021 Sangfor Ltd. All rights reserved.
# File Name   : Makefile
# Author      : bhyou
# mail        : bhyou@foxmail.com
# Created Time: Mon 13 Dec 2021 08:43:41 AM CST
#########################################################################

########################################################################
# The steps of compiling vhdl-verilog mixed design: 
#     1. analyse hdl codes : 
#     	- vhdlan -full64 -nc  -f vhdllist.f
#     	- vlogan -full64 +v2k -f vloglist.f
#     2. elaborate design  : vcs -full64 -debug_pp -top ${topDesign}
#     3. simulation        : ./simv -gui 
# Note : The simulation tools must be VCS-MX not VCS. 
#        VCS not supports vhdl compile.
########################################################################

.PHONY:default help clean file vlogcom vhdlcom mixecom 

default: help

waveFormat = vpd
topDesign  = top_tb
comLog     = compile.log
simLog     = sim_tb.log
 
vhdlFileList = yes; # vhdllist.f should be provided
vlogFileList = yes; # vloglist.f should be provided

#vhdlFileList ?= no
#VHDL_DUT_SRC += ../hdl/not_gate.vhd
#VHDL_TB_SRC  += ../bench/not_gate_tb.vhdl

#vlogFileList ?= no
#VLOG_DUT_SRC += ../hdl/not_gate.v
#VLOG_TB_SRC  += ../bench/not_gate_tb.sv


VLOG_CMP_ARGS += -override_timescale=1ns/1ps
#VLOG_CMP_ARGS += +define+Tdelay=200
#VLOG_CMP_ARGS += +incdir+../rtl/include
#VLOG_CMP_ARGS += -y <verilog library directory path> +libext++.v

# Get absolute path of current makefile
#CURPATH := $(abspath $(lastword $(MAKEFILE_LIST)))

# Get relative path of current makefile
#CURDIR := $(dir $(lastword $(MAKEFILE_LIST)))

#Convert relative path strength to absolute path
#$(eval PRJDIR := $(abspath $(CURDIR)))

#####################################################################################
# No need to modify anything below
#####################################################################################
#================================================
# *_CMP_ARGS: means compile-time options
#================================================
COV_CMP_ARGS += -cm line+cond+tgl+fsm+branch+assert 

ARCH_ARGS += -full64 

VLOG_CMP_ARGS += +v2k
VLOG_CMP_ARGS += -sverilog 
VLOG_CMP_ARGS += -l ${comLog}
ELAB_CMP_ARGS += -debug_access+all
#================================================
# *_RUN_ARGS: means Run-time options
#================================================
COV_RUN_ARGS += -cm line+cond+tgl+fsm+branch+assert 

#INFO_RUN_ARGS += -a <filename>; # specifies appending all messags

#VERDI_RUN_ARGS += -gui=verdi
#VERDI_RUN_ARGS += -verdi
#VERDI_RUN_ARGS += -verdi_opts

#VCD_RUN_ARGS += -vcd <filename>; # sets the output VCD file name

ifeq ($(waveFormat),fsdb) 
  VLOG_CMP_ARGS += +define+fsdb
  FSDB_CMP_ARGS += -fsdb -kdb
endif

ifeq ($(vhdlFileList),yes) 
  VHDL_FILES := -f vhdllist.f
else
  VHDL_FILES += $(VHDL_DUT_SRC)
  VHDL_FILES += $(VHDL_TB_SRC) 	
endif

ifeq ($(vlogFileList),yes)
  VLOG_FILES := -f vloglist.f
else
  VLOG_FILES += $(VLOG_DUT_SRC)
  VLOG_FILES += $(VLOG_TB_SRC) 	
endif

usage:
	@echo  "====================================================================== "
	@echo  "print the following info about how to use:"
	@echo  "====================================================================== "

var:
	@echo  "====================================================================== "
	@echo   "        " 
	@echo   " variable print:              " 
	@echo   " VHDL_DUT_SRC => list of vhdl source files      " 
	@echo   " VHDL_TB_SRC  => list of vhdl testbench files      " 
	@echo   " VLOG_DUT_SRC => list of verilog or SV source files       " 
	@echo   " VLOG_TB_SRC  => list of verilog or SV testbench files        " 
	@echo   " vlogFileList => whether enable vloglist.f       " 
	@echo   " vhdlFileList => whether enable vhdllist.f       " 
	@echo "======================================================================="
	
help: 
	@echo ======================================================================= 
	@echo   "        " 
	@echo   " USAGE: %make target_name_*              " 
	@echo   "        " 
	@echo   " ------------------------ DEBUG TARGETS ----------------------------" 
	@echo   " file         => Generate file lsit of vhdl and verilog in ../directory" 
	@echo   " clean        => Clean the intermediate files.                      " 
	@echo   " vhdlcom      => Compile the TB and DUT writed by vhdl.             " 
	@echo   " vlogcom      => Compile the TB and DUT writed by verilog / systemverilog." 
	@echo   " mixcom       => Compile the TB and DUT writed by vhdl-verilog.           " 
	@echo   " guiDve       => Run simulation interactively with DVE.          " 
	@echo   " guiVerdi     => Run simulation interactively with Verdi.        " 
	@echo   " dveCcov      => Brings up DVE for coverage reporting.           " 
#	@echo   " run_*        => Run the simulation.                             " 
#	@echo   " tb_gui_*     => Runs simulation interactively with TB Debugger. " 
#	@echo   " new_gui_*    => Run new integrated debuggers.                " 
#	@echo   " urg          => Make a coverage report for debug runs.       " 
	@echo   "                                                                    " 
	@echo   " -------------------- ADMINISTRATIVE TARGETS -----------------------" 
	@echo   " help           => Displays this message.                         " 
#	@echo   " initial        => Clean all files, including coverage files.    " 
#	@echo   " tar            => Tar and zip kit and place at ../                 " 
	@echo   "        " 
	@echo   " e.g.   gmake test_1                                              " 
	@echo ======================================================================= 

clean:  
	@rm -fr simv* csrc* ucli* 64 AN* DVE* *.vpd  *.log  vhdlcomLog

file:
	@touch vloglist.f
	@find .. -name "*.*v" > vloglist.f
ifneq ($(wildcard ../*/*.vhd),)
	@find .. -name  "*.vhd" > vhdllist.f 
endif

vlogcom: 
	@echo "$(VLOG_FILES)"
	vcs $(ARCH_ARGS) $(VLOG_CMP_ARGS) $(ELAB_CMP_ARGS) \
		 $(COV_CMP_ARGS) $(VLOG_FILES)
 
vhdlcom:  
	@echo "$(vhdlFileList)"
	@echo $(VHDL_FILES)
	vhdlan $(ARCH_ARGS) -nc $(VHDL_FILES)
	vcs $(ARCH_ARGS) $(ELAB_CMP_ARGS) -l ${comLog} -top ${topDesign}

mixcom: 
	vhdlan $(ARCH_ARGS) -nc $(VHDL_FILES)
	vlogan $(ARCH_ARGS) -nc $(VLOG_CMP_ARGS) $(VLOG_FILES) 
	vcs $(ARCH_ARGS) $(ELAB_CMP_ARGS) -top $(topDesign) -l elab.log $(comOpt)

guiDve: simv 
	@./simv -l $(simLog) -gui & 

guiVerdi: simv
	@./simv -l $(simLog) -gui=verdi &
 
dveCov: simv
	@./simv -l $(simLog) $(COV_RUN_ARGS) &

viewCov: simv.vdb
	dve -full64 -covdir simv.vdb 

viewFsdb:
	verdi -nologo -ssf ${fsdbFile} &

viewVpd:
	dve -full64 -cov -dir simv.vpd &

 
