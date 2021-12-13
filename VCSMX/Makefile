#---------------------------------------------------------------------------------------
# SYNOPSYS CONFIDENTIAL - This is an unpublished, proprietary work of 
# Synopsys, Inc., and is fully protected under copyright and trade secret 
# laws. You may not view, use, disclose, copy, or distribute this file or 
# any information contained herein except pursuant to a valid written 
# license from Synopsys. 
#---------------------------------------------------------------------------------------

#---------------------------------------------------------------------------------------
#  Filename : $Id: Makefile,v 1.0 2006/07/18 23:59:59 vangundy Exp $ 
#  Created by   : Synopsys Inc. 07/17/2006 
#  $Author     : vangundy $ 
#  Description : Demonstrates Verilog DUT and SVTB using VCS
#---------------------------------------------------------------------------------------

#-----------------------------------------------------------------------------
# DIRECTORIES
#-----------------------------------------------------------------------------
OUTPUT_DIR = ./output
COV_DIR = ./coverage
LOG_DIR = ./logs
# Set this to the location where you installed the designware models. This
# depends on whether you ran the setup_vip_dw_home to install the models or
# the setup_vip_here script.
#DW_MODELS_DIR = $(DESIGNWARE_HOME)
DW_MODELS_DIR = /user/synopsys/designware
#DESIGNWARE_HOME = ~synopsys/bk/designware
#DW_MODELS_DIR = ./designware

#----------------------------------------------------------------------------
# DEVICE UNDER TEST
#-----------------------------------------------------------------------------
DUT_SRC_DIR = ./source/verilog
DUT_SRC = -f $(DUT_SRC_DIR)/rtl_list.f

DUT_INC += +incdir+/user/myproj/PROJECT/RTL/SRC/mymodule/
DUT_CMP_OPTIONS += +libext+.v
#DUT_CMP_OPTIONS += -timescale=1ps/1ps
#DUT_CMP_OPTIONS += -override_timescale=1ps/1ps

#-----------------------------------------------------------------------------
# TESTBENCH
#-----------------------------------------------------------------------------
TB_SRC_DIR = ./source/svtb
#TB_SRC += -f $(TB_SRC_DIR)/mac_if_tb/vip/gslv_model_package.f
TB_SRC += $(TB_SRC_DIR)/mpdu_trx_tb/tests/mpdu_tb_top.sv
TB_SRC += $(TB_SRC_DIR)/mpdu_trx_tb/tests/$(TB_TEST).sv

TB_INC += +incdir+$(TB_SRC_DIR)/mpdu_trx_tb/vip
TB_INC += +incdir+$(TB_SRC_DIR)/mpdu_trx_tb/env
TB_INC += +incdir+$(TB_SRC_DIR)/mpdu_trx_tb/tests
TB_INC += +incdir+$(DW_MODELS_DIR)/include/svtb
TB_INC += +incdir+$(DW_MODELS_DIR)/include/verilog
TB_INC += +incdir+$(DW_MODELS_DIR)/svtb

#TB_CMP_OPTIONS += -tb_timescale=1ns/1ps
#TB_CMP_OPTIONS += -lca Y-2006.06-SP2
TB_CMP_OPTIONS += +pkgdir+$(DW_MODELS_DIR)/include/svtb
TB_CMP_OPTIONS += -ntb_incdir $(DW_MODELS_DIR)/include/vera
TB_CMP_OPTIONS += -ntb_incdir $(DESIGNWARE_HOME)/vip/vmt/latest/vera/src
TB_CMP_OPTIONS += -ntb_incdir $(DESIGNWARE_HOME)/vip/amba/latest/vera/src
TB_CMP_OPTIONS += -ntb_incdir $(DESIGNWARE_HOME)/vip/amba/latest/axi_master_vmt/vera/src
TB_CMP_OPTIONS += -ntb_incdir $(DESIGNWARE_HOME)/vip/amba/latest/axi_master_rvm_vera_vmt/vera/src
TB_CMP_OPTIONS += -ntb_incdir $(DESIGNWARE_HOME)/vip/amba/latest/axi_slave_vmt/vera/src
TB_CMP_OPTIONS += -ntb_incdir $(DESIGNWARE_HOME)/vip/amba/latest/axi_slave_rvm_vera_vmt/vera/src
TB_CMP_OPTIONS += -ntb_incdir $(DESIGNWARE_HOME)/vip/amba/latest/axi_monitor_vmt/vera/src
TB_CMP_OPTIONS += -ntb_incdir $(DESIGNWARE_HOME)/vip/amba/latest/axi_monitor_rvm_vera_vmt/vera/src
TB_CMP_OPTIONS += -ntb_incdir $(DESIGNWARE_HOME)/vip/amba/latest/axi_port_monitor_vmt/vera/src
TB_CMP_OPTIONS += -ntb_incdir $(DESIGNWARE_HOME)/vip/amba/latest/axi_port_monitor_rvm_vera_vmt/vera/src
TB_CMP_OPTIONS += -ntb_incdir $(DESIGNWARE_HOME)/vip/amba/latest/axi_interconnect_vmt/vera/src
TB_CMP_OPTIONS += -ntb_incdir $(DESIGNWARE_HOME)/vip/amba/latest/axi_interconnect_rvm_vera_vmt/vera/src
TB_CMP_OPTIONS += -ntb_incdir ${DESIGNWARE_HOME}/vip/amba/latest/ahb_master_vmt/vera/src
TB_CMP_OPTIONS += -ntb_incdir ${DESIGNWARE_HOME}/vip/amba/latest/ahb_slave_vmt/vera/src
TB_CMP_OPTIONS += -ntb_incdir ${DESIGNWARE_HOME}/vip/amba/latest/ahb_monitor_vmt/vera/src
TB_CMP_OPTIONS += -ntb_incdir ${DESIGNWARE_HOME}/vip/amba/latest/ahb_bus_vmt/vera/src
TB_CMP_OPTIONS += -ntb_incdir ${DESIGNWARE_HOME}/vip/amba/latest/ahb_master_rvm_vera_vmt/vera/src
TB_CMP_OPTIONS += -ntb_incdir ${DESIGNWARE_HOME}/vip/amba/latest/ahb_slave_rvm_vera_vmt/vera/src
TB_CMP_OPTIONS += -ntb_incdir ${DESIGNWARE_HOME}/vip/amba/latest/ahb_monitor_rvm_vera_vmt/vera/src
TB_CMP_OPTIONS += -ntb_incdir ${DESIGNWARE_HOME}/vip/amba/latest/ahb_bus_rvm_vera_vmt/vera/src

TB_CMP_OPTIONS += -ntb_define NTB
TB_CMP_OPTIONS += -ntb_define DW_VIP_AXI_MAX_NO_MSTRS=6
TB_CMP_OPTIONS += -ntb_define DW_VIP_AXI_MAX_NO_SLVS=2

TB_CMP_OPTIONS += +define+DW_VIP_AXI_MAX_NO_MSTRS_6
TB_CMP_OPTIONS += +define+DW_VIP_AXI_MAX_NO_SLVS_2
TB_CMP_OPTIONS += -ntb_opts rvm
TB_CMP_OPTIONS += -ntb_opts dtm
TB_CMP_OPTIONS += -ntb_opts use_sigprop
TB_CMP_OPTIONS += -ntb_opts interop
TB_CMP_OPTIONS += -ntb_opts dw_vip
TB_CMP_OPTIONS += +define+NT


# AIP Related files and compilation options
#TB_CMP_OPTIONS += +incdir+../BP062-BU-01000-r0p0-00rel0/sva \
                           ../BP062-BU-01000-r0p0-00rel0/verilog \
                           ../BP062-BU-01000-r0p0-00rel0/sva/AxiPC.sv \
                           ../BP062-BU-01000-r0p0-00rel0/verilog/Axi.v \
                           ./source/svtb/platform_tb/env/Snps_ARMAXI_CheckerBind.sv

#-----------------------------------------------------------------------------
# COVERAGE
#-----------------------------------------------------------------------------
COV_TREE += '+tree mpdu_tb_top'
COV_CM_OPTIONS += -cm line+cond+fsm+assert

#-----------------------------------------------------------------------------
# TEST TARGETS
#-----------------------------------------------------------------------------
# debug targets
test_1: compile_1 run_1
test_11: compile_11 run_11
test_12: compile_12 run_12
test_13: compile_13 run_13
test_14: compile_14 run_14
test_2: compile_2 run_2
test_perf: compile_perf run_perf

# regression targets
regress_test_1: regress_build_1 regress_run_1
regress_test_11: regress_build_11 regress_run_11
regress_test_12: regress_build_12 regress_run_12
regress_test_13: regress_build_13 regress_run_13
regress_test_14: regress_build_14 regress_run_14
regress_test_2: regress_build_2 regress_run_2
regress_test_perf: regress_build_perf regress_run_perf

#-----------------------------------------------------------------------------
# COMPILE AND RUN TIME ARGUMENTS
#-----------------------------------------------------------------------------
# Debug compile time arguments
DBG_CMP += $(COV_CMP_OPTIONS)
DBG_CMP += -debug_all
#DBG_CMP += -debug_pp
DBG_CMP += +define+VPD_ON
#DBG_CMP += +define+VPD_OFF
#DBG_CMP += +define+LOG_FMT_OFF

# Debug run time arguments
DBG_RUN += $(COV_SIM_OPTIONS)

# Regression compile time arguments
REG_CMP += $(COV_CMP_OPTIONS)
REG_CMP += +define+VPD_OFF

# Regression run time arguments
REG_RUN += $(COV_SIM_OPTIONS)

# Define where the coverage data is for URG
COV_DBG_DATA += -dir $(COV_DIR)/debug/simv.vdb -dir $(COV_DIR)/debug/simv.cm
COV_REG_DATA += -dir $(COV_DIR)/regress/simv.vdb -dir $(COV_DIR)/debug/simv.cm

#-----------------------------------------------------------------------------
# COMMAND LINE ARGUMENTS
#-----------------------------------------------------------------------------
SEED = 766
#DEFINES = "+rvm_log_default=DEBUG"
DEFINES = "+vmm_log_default=DEBUG"
#DEFINES = "+vmm_log_default=NOTE"
#DEFINES = "+rvm_log_default=WARNING"
#DEFINES = "+vmm_log_default=ERROR"

##############################################################################
# PRIVATE
# You should not need to modify anything below this point
# The following code supports a SV DUT and SVTB.
##############################################################################
DIR = /user/synopsys/Gaon/Platform

##########################################################################
# DEVICE UNDER TEST arguments
##########################################################################
DUT_CMP_OPTIONS += -sverilog +v2k
DUT_CMP_OPTIONS += -o $(DUT_SIM_EXEC)
DUT_CMP_OPTIONS += -Mdir=$(OUTPUT_DIR)/$(TB_TEST_ID)_csrc
DUT_CMP_OPTIONS += -l $(LOG_DIR)/$(TB_TEST).cmp_log
DUT_CMP_OPTIONS += +vcs+lic+wait +plusarg_save
DUT_CMP_OPTIONS += $(DUT_INC)

DUT_SIM_OPTIONS += -l $(LOG_DIR)/$(TB_TEST_ID).run_log
DUT_SIM_OPTIONS += +vcs+lic+wait
DUT_SIM_OPTIONS += +vpdfile+$(OUTPUT_DIR)/$(TB_TEST_ID).vpd
#DUT_SIM_OPTIONS += +ntb_random_seed=$(SEED)
DUT_SIM_OPTIONS += +ntb_random_seed_automatic
DUT_SIM_OPTIONS += -assert nopostproc+report=$(LOG_DIR)/$(TB_TEST_ID).sva_log
DUT_SIM_OPTIONS += -cm_assert_name $(TB_TEST_ID)
DUT_SIM_OPTIONS += $(DEFINES)

DUT_SIM_EXEC += $(OUTPUT_DIR)/$(TB_TEST)_simv

##########################################################################
# TESTBENCH
##########################################################################
TB_TEST += test_$*
TB_TEST_ID += $(TB_TEST)_$(SEED)
# VK ENVIRONMENT
TB_INC += +incdir+$(TB_SRC_DIR)/vk
TB_CMP_OPTIONS += $(TB_INC)

##########################################################################
# COVERAGE
##########################################################################
#COV_CM_OPTIONS += +tb_cov_db_name=$(TB_TEST_ID)
COV_CM_OPTIONS += -cm_name $(TB_TEST_ID)
COV_CMP_OPTIONS += $(COV_CM_OPTIONS) -cm_hier $(COV_HIER)
COV_SIM_OPTIONS += $(COV_CM_OPTIONS)
COV_SIM_OPTIONS += -cm_log $(LOG_DIR)/$(TB_TEST_ID).cm_log

COV_HIER += $(OUTPUT_DIR)/vcm.cfg

# Coverage options for build and run with debug
COV_CM_DBG += -cm_dir $(COV_DIR)/debug/simv.cm
#COV_CM_DBG += -ova_dir $(COV_DIR)/debug/simv.vdb
#COV_CM_DBG += +tb_cov_db_dir=$(COV_DIR)/debug/simv.vdb

# Coverage options for build and run with regressions
COV_CM_REG += -cm_dir $(COV_DIR)/regress/simv.cm
COV_CM_REG += -ova_dir $(COV_DIR)/regress/simv.vdb
COV_CM_REG += +tb_cov_db_dir=$(COV_DIR)/regress/simv.vdb

##########################################################################
# DEBUG TARGETS
##########################################################################
compile_%:
   echo $(COV_TREE) > $(COV_HIER);
   vcs $(TB_CMP_OPTIONS) $(DUT_CMP_OPTIONS) $(DUT_SRC) $(TB_SRC) \
      $(SVA_SRC) $(SVA_OPTIONS) $(COV_CM_DBG) $(DBG_CMP)

run_%:
   $(DUT_SIM_EXEC) $(DUT_SIM_OPTIONS) $(DBG_RUN) $(COV_CM_DBG)

gui_%:
   $(DUT_SIM_EXEC) $(DUT_SIM_OPTIONS) $(DBG_RUN) $(COV_CM_DBG) -gui

tb_gui_%:
   $(DUT_SIM_EXEC) $(DUT_SIM_OPTIONS) $(DBG_RUN) $(COV_CM_DBG) -tb_gui +ntb_debug_on_start

both_guis_%:
   $(DUT_SIM_EXEC) $(DUT_SIM_OPTIONS) $(DBG_RUN) $(COV_CM_DBG) -gui -tb_gui +ntb_debug_on_start

new_gui_%:
   $(DUT_SIM_EXEC) $(DUT_SIM_OPTIONS) $(DBG_RUN) $(COV_CM_DBG) -gui -tbug

pp_%:
   dve -vpd $(OUTPUT_DIR)/$(TB_TEST_ID).vpd

urg:
   urg $(COV_DBG_DATA) -report $(COV_DIR)/debug/urgReport -lca
   mozilla $(DIR)/$(COV_DIR)/debug/urgReport/dashboard.html &

dve_cov:
   @echo ""
   @echo "WARNING: Did you run this command?"
   @echo ""
   @echo " % source ./utils/setup_dve_cov"
   @echo ""
   dve -cov &

##########################################################################
# REGRESSION TARGETS
###########################################################################
regress_clean: clean
   @rm -rf $(COV_DIR)/*
   @mkdir -p $(COV_DIR)/debug
   @mkdir -p $(COV_DIR)/regress
   @mkdir -p $(LOG_DIR)
   @mkdir -p $(OUTPUT_DIR)

regress_build_%:
   echo $(COV_TREE) > $(COV_HIER);
   vcs $(TB_CMP_OPTIONS) $(DUT_CMP_OPTIONS) $(DUT_SRC)  $(TB_SRC) \
      $(SVA_OPTIONS)  $(SVA_SRC) $(COV_CM_REG) $(REG_CMP)

regress_run_%:
   $(DUT_SIM_EXEC) $(DUT_SIM_OPTIONS) $(REG_RUN) $(COV_CM_REG)

regress_urg:
   urg $(COV_REG_DATA) -grade -report $(COV_DIR)/regress/urgReport
   mozilla $(DIR)/$(COV_DIR)/regress/urgReport/dashboard.html &

regress_dve_cov:
   @echo ""
   @echo "WARNING: Did you run this command?"
   @echo ""
   @echo " % source ./utils/setup_dve_cov"
   @echo ""
   dve -cov &


##########################################################################
# ADMINISTRATIVE
##########################################################################
help:
   @echo "================================================================ 
   @echo " "
   @echo " USAGE: %make target_name_* <SEED=xxx> <DEFINES=xxxx> "
   @echo " "
   @echo " ------------------------ DEBUG TARGETS ----------------------------"
   @echo " test_* => Compile TB and DUT files, runs the simulation. "
   @echo " clean => Clean the intermediate files. "
   @echo " compile_* => Compile the TB and DUT. "
   @echo " run_* => Run the simulation. "
   @echo " gui_* => Run simulation interactively with DVE. "
   @echo " tb_gui_* => Runs simulation interactively with TB Debugger. "
   @echo " both_guis_* => Run both debuggers. "
   @echo " new_gui_* => Run new integrated debuggers. "
   @echo " pp_* => Post process VPD with DVE. "
   @echo " urg => Make a coverage report for debug runs. "
   @echo " dve_cov => Brings up DVE for coverage reporting. "
   @echo " "
   @echo " ----------------------- REGRESSION TARGETS ------------------------"
   @echo " regress_test_* => Compile and run with coverage. "
   @echo " regress_clean => Remove all coverage files. "
   @echo " regress_build_* => Build test_*. "
   @echo " regress_run_* => Run test * collecting coverage information. "
   @echo " regress_urg => Make a coverage report for regression runs. "
   @echo " regress_dve_cov => Brings up DVE for coverage reporting. "
   @echo " "
   @echo " -------------------- ADMINISTRATIVE TARGETS -----------------------"
   @echo " help => Displays this message. "
   @echo " init => Clean all files, including coverage files. "
   @echo " tar => Tar and zip kit and place at ../ "
   @echo " "
   @echo " e.g. gmake test_1 "
   @echo "===================================================================="

tar: clean
   cd ..; \
   tar cvf ${DIR}.tar ${DIR}; \
   rm -f ${DIR}.tgz; \
   gzip ${DIR}.tar; \
   mv ${DIR}.tar.gz ${DIR}.tgz

clean:
   @rm -rf $(OUTPUT_DIR)/* $(COV_DIR)/debug/* $(LOG_DIR)/* ./DVEfiles
   @rm -rf urgReport *.tcl *.tcl.old vc_hdrs.h testbench_debugger_rc
   @rm -rf ucli.key vcs.key vera_debugger_rc .vera_debugger_rc.lock
   @rm -rf .test* .vlog* .dummyDir *.db *.vdb verilog.dump
   @rm -rf ._* .dw* *.log
   
init: regress_clean
   @rm -rf include
   @rm -rf examples




