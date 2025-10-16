# RV32I_SC

A simple, single-cycle implementation of the RISC-V RV32I instruction
set architecture.\
This project was built for learning, experimentation, and extending
toward more advanced CPU designs.

------------------------------------------------------------------------

## Overview

This core implements the base RV32I instruction set, focusing on clarity
and correctness rather than performance.\
It's written in Verilog and can be simulated using standard open-source
tools.

The design follows a straightforward single-cycle architecture: - Fetch
→ Decode → Execute → Memory → Write-back\
- Supports all basic arithmetic, logical, and control instructions.\
- Memory interface designed for easy integration with testbenches and
simple memory models.

------------------------------------------------------------------------

## Directory Structure

    RV32I_SC/
    │
    ├── asm/        # Assembly programs for testing
    ├── docs/       # Documentation, diagrams, and notes
    ├── dumps/      # Simulation output files
    ├── misc/       # Utility scripts or helper files
    ├── sim/        # Simulation environment and scripts
    ├── src/        # Main Verilog source files
    ├── tb/         # Testbenches
    └── tests/      # Test cases and programs

------------------------------------------------------------------------

## Getting Started

### Prerequisites

You'll need: - **Icarus Verilog** or **Verilator** for simulation\
- **GTKWave** for waveform viewing\
- (Optional) **RARS** or **Spike** for assembling RISC-V test programs

### Build & Run

``` bash
# Compile and run simulation
make run
```

or manually:

``` bash
iverilog -o simv src/*.v tb/*.v
vvp simv
gtkwave dump.vcd
```

------------------------------------------------------------------------

## Example

To run a simple test program:

``` bash
cd asm
make hello
make run
```

------------------------------------------------------------------------

## Future Work

-   Add support for `sb`, `sh`, and other remaining instructions\
-   Implement a pipelined version\
-   Add hazard detection and forwarding\
-   Integrate instruction/data caches

------------------------------------------------------------------------

## License

This project is licensed under the **MIT License** -- see the
[LICENSE](LICENSE) file for details.
