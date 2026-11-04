# SystemVerilog Two-Stage Pipeline

An 8-bit, two-stage pipeline with synchronous reset and enable control,
verified with a self-checking SystemVerilog testbench.

## Files

- `pipeline.sv` — pipeline module.
- `pipeline_tb.sv` — clock generation, test inputs, and automated checks.

## Behavior

At each rising clock edge:

- If reset is high, both stages clear to zero, regardless of enable.
- Otherwise, if enable is high, stage1 captures data_in and stage2
  captures the previous value of stage1.
- Otherwise, both stages hold their values.

Reset is synchronous: asserting reset between rising edges does not
immediately clear the registers.

## Verification

The testbench checks:

- Synchronous reset.
- Data transfer through both stages.
- Hold behavior when enable is low.
- Resuming transfers after enable is restored.
- Reset priority when reset and enable are both high.

All checks passed using Icarus Verilog 12.0 in WSL.

## Run

From the folder containing both source files:

```bash
iverilog -g2012 -s pipeline_tb -o simulation pipeline.sv pipeline_tb.sv
vvp simulation
```

Expected success message:

```text
PASS: reset, transfer, hold, resume, and reset priority
```

A failed check stops the simulation with a descriptive error.
