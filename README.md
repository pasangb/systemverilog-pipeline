#SystemVerilog Two-Stage Pipeline

A beginner hardware simulation project implementing a 8-bit, 
two-stage pipeline with synchronous reset and enable control. 

##Behavior 
- Reset clears both registers at the rising clock edge. 
- Enable allows data to move through the pipeline. 
- When reset and enable are low (0), both registers hold their values. 
- Nonblocking assignments make stage2 capture the previous stage1 value. 

##Verification 
A self-checking testbench checks reset, data transfers, and hold behavior. 
The simulation passed using Icarus Verilog in WSL. 

##Run 

```bash
iverilog -g2012 -s pipeline_tb -o pipeline_sim pipeline_tb.sv
vvp pipeline_sim
```
Expected output: 
```text
PASS: reset, transfer, and hold
```
