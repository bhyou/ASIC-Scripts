# Synopsys VCSMX Makefile

The Makefile works on two separate flows. The DEBUG flow is intended to be used 
During debugging of a testcase and/or the DUT. The REGRESSION flow is used 
During regression runs and collects coverage data. 

  - The **DEBUG flow** turns on VPD dumping and turns off coverage collection. After building a testcase using the debug targets, you can debug the TB and the DUT source code using the testbench debugger and DVE. Of course, you can turn on coverage metrics and run in debug mode by changing compile and runtime options in the makefile. These changes are independent of the regression flow so that the regressions will still run optimally without the interference of VPD dumping. 

  - The **REGRESSION flow** turns off VPD dumping and turns on Coverage Metrics and TB  coverage collection. This flow is intended to support verification engineers who are working through the regression process and are interested in coverage collection and urg. 

该Makefile包含**Debug**和**Regression**两个流程。Debug流程用于调试和查错； Regression流程则用于覆盖率收集(即是检查验证是否充分)。
  - Debug流程中，存储VPD波形，不进行覆盖率收集。 编译目标testcase后，可以使用DVE调试Testbench和DUT源代码。
  - Regressionl流程中，不存储VPD波形，进行覆盖率收集。

## **Command Line**
--------------------------------------------------------
The Makefile supports the following command line:
```bash
  % make target_name_* <SEED=xxx> <DEFINES=xxxx>
```
Where **target_name** is the name of a testcase located in the test directory. Every test in the test directory is named using `test_{test_name}`.  All of the test targets are listed in the *TEST TARGETS* section of the makefile.

### **Compile and Run Testcases**
--------------------------------------------------------
To compile and run a tescase use the `test_*` and `regress_test_*` targets. 
```
  % make test_1         // Builds and runs test 1 with VPD dumping  
  % make regress_test_1 // Builds and runs test 1 with coverage turned on 
```

### **Debugging Testcases**  
--------------------------------------------------------
You can use DVE and the testbench debugger to visualize waveforms and testbench execution.   You must first build the testbench using the make `compile_*` command.
```
  % make compile_1        // Builds test 1 for debugging    
```
Once you have built the environment with the proper debug switches, you can use DVE and the testbench debugger. 
```
  % make gui_1          // Debug test 1 with DVE 
  % make tb_gui_1       // Debug test 1 with the testbench debugger 
  % make both_guis_1    // Debug using both guis 
  % make pp_1           // Debug using the VPD file 
``` 
If you want, you can turn on coverage for the DEBUG flow by uncommenting the coverage flag in the makefile.   If you do this, you can still look at coverage. This may be useful in helping those who are debugging coverage related issues. 
```
   % make urg              // Visualize coverage data from debug runs 
```

### **Regression Testcases**
--------------------------------------------------------
Regression tests are used to collect coverage information. To build a testcase for coverage collection use a command similar to the following. 
```
   % make regress_build_1   // Build and run a regression test with a default seed 
```
Once the test has been built, you can run it again with a new seed. 
```
  % make regress_run_1 SEED=1234 
```
After running one or more regression runs, you can visualize the coverage data using urg and the following command 
```
   % make regress_urg 
```
## **HOW TO REUSE THIS FILE ON ANOTHER DUT**
--------------------------------------------------------
  1. Update the **file locations** as required   
  2. Update the **DUT section with directory and source location** info 
  3. Update the **TB section with directory and source location** info 
  4. Update the **Coverage section with name of dut top** (eg top.dut)  
  5. **Add test targets** to the debug and regression targets section 
  5. Adjust the debug and regression **compile and run time arguments**
  7. Adjust **command line options** as required 
  8. Update the env class so that it extends dkm_env
     * You will need to have a copy of the dkm directory and it should be located at $(TB_SRC_DIR)/dkm 
       1. Add [`include "dkm_env.sv"] 
       2. Add [extends dkm_env] to the environment class definition 
       3. Call the super.new("name") from the constructor 
  9. Run the debug and regression targets 
      * `% make testbench_target_*   // testbench_target_*`   

