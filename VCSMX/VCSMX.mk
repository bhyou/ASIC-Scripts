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

.PHONY:default help clean file vlogcom vhdlan mixecom 

default: help


waveFormat ?= vpd
topDesign  ?= top_tb
comLog     ?= compile.log
simLog     ?= sim_tb.log
 
UseFileList?= yes

# UseFileList ?= no
# FILES += not_gate.v
# FILES += not_gate_tb.v

# coverage options
coverOpt += -cm line+cond+tgl+fsm+branch+assert

# interactive simulation on verdi and vcs
comOpts += -lca -kdb

comOpts += -full64 -sverilog +v2k -l ${comLog}
comOpts += -override_timescale=1ns/1ps
comOpts += -debug_access+r

#macroOpt += +define+Tdelay=200
#macroOpt += +incdir+../rtl/include

ifeq ($(waveFormat),vpd)
	macroOpt += +define+VPD
else
	macroOpt += +define+fsdb
	comOpt += -fsdb
endif

ifeq (${UseFileList}, yes)
	FILES = -file $(filelist)
	filelist = vloglist.f
endif

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
	vcs $(comOpt) $(macroOpt) $(FILES)
 
vhdlcom: vhdllist.f
	vhdlan -full64 -nc -f vhdllist.f
	vcs -full64 -debug_pp -l ${comLog} -top ${topDesign}

mixcom: vhdllist.f vloglist.f
	vhdlan -fulll64 -nc vhdlist.f
	vlogan -full64 +v2k -sverilog +define+syn_off vloglist.f 
	vcs -full64 -debug_pp -top $(topDesign) -l elab.log $(comOpt)

guiDve: simv 
	@./simv -l $(simLog) -gui & 

guiVerdi: simv
	@./simv $(simOpt) -gui=verdi &
 
dveCov: simv
	@./simv $(simOpt) $(coverOpt) &

viewCov: simv.vdb
	dve -full64 -covdir simv.vdb 

viewFsdb:
	verdi -nologo -ssf ${fsdbFile} &

viewVpd:
	dve -full64 -cov -dir simv.vpd &

 
