# RV32I_SC

A single-cycle RISC-V RV32I core implemented in SystemVerilog,
based on the DDCA implementation by Harris and extended to support all
missing instructions, achieving 100% instruction coverage
This design is intended for experimentation and further
development toward pipelined or cached variants.

------------------------------------------------------------------------

## Overview

The core is written entirely in SystemVerilog and follows a **clean,
single-cycle** architecture for simplicity and readability
Instruction fetch, decode, execute, memory, and writeback occur within
one clock cycle.

Key features: - Complete **RV32I base instruction set** support
- Built upon the Harris DDCA core with additional modules
- Modular structure with clear separation between control and datapath
- Compatible with open-source simulators such as **Icarus Verilog**,
**Verilator**, and **GTKWave**.

------------------------------------------------------------------------

## Directory Structure

    RV32I_SC/
    │
    ├── asm/        # Assembly programs for testing
    ├── docs/       # Documentation, diagrams, and notes
    ├── dumps/      # Simulation output files
    ├── misc/       # Utility scripts or helper files
    ├── sim/        # Simulation environment and scripts
    ├── src/        # Main SystemVerilog source files
    ├── tb/         # Testbenches
    └── tests/      # Test cases and programs

------------------------------------------------------------------------

## Module Overview

### **Top-Level**

-   **`top.sv`** --- SoC wrapper; instantiates CPU (`rv32i_sc`),
    instruction memory, and data memory
-   **`rv32i_sc.sv`** --- Main CPU core integrating the controller and
    datapath.

### **Control Path**

-   **`controller.sv`** --- Generates control signals and coordinates
    the instruction flow
-   **`main_decoder.sv`** --- Decodes opcodes into high-level control
    signals (e.g., RegWrite, ALUSrc, MemToReg)
-   **`alu_decoder.sv`** --- Decodes funct3/funct7 fields for specific
    ALU operations
-   **`branch_logic.sv`** --- Evaluates branch conditions and determines
    branch decisions.

<img width="1193" height="983" alt="controller drawio (3)" src="https://github.com/user-attachments/assets/57dbcb31-f7d2-4510-a769-4e29a5a8e6c3" />

### **Datapath**

-   **`datapath.sv`** --- Connects the ALU, register file, immediate
    logic, and multiplexers
-   **`regfile.sv`** --- 32×32 register file with two read ports and one
    write port (x0 = 0)
-   **`alu.sv`** --- Implements arithmetic, logical, and shift
    operations
-   **`adder.sv`** --- Simple adder for PC increment and branch
    targets
-   **`imm_extend.sv`** --- Extracts and sign-extends immediates for all
    instruction types
-   **`load_extender.sv`** --- Extends byte/halfword loads with correct
    sign or zero extension.

<img width="1760" height="753" alt="RV32I_SC" src="https://github.com/user-attachments/assets/61bf6164-7f5f-4f3c-9e69-a7535b6f77fa" />


### **Memory & I/O**

-   **`imem.sv`** --- Instruction memory (read-only, initialized from
    file)
-   **`dmem.sv`** --- Data memory (read/write) with byte and halfword
    granularity.

### **Utility / Infrastructure**

-   **`mux2_1.sv`, `mux3_1.sv`, `mux4_1.sv`** --- Multiplexers used
    throughout the datapath
-   **`ff_r.sv`, `ff_enr.sv`** --- Flip-flops with reset and optional
    enable.

------------------------------------------------------------------------

## Future Work

-   Add compressed (`C`) and multiplication (`M`) extensions
-   Implement a pipelined version with hazard detection
-   Add instruction and data cache modules
-   Extend verification with self-checking testbenches

------------------------------------------------------------------------

## License

This project is released under the **MIT License** -- see the
[LICENSE](LICENSE) file for details.
