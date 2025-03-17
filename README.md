# TIMER0 Module for BASYS3
## Overview
This project implements a TIMER0 module on the BASYS3 FPGA development board using VHDL. The module is designed to operate as an 8-bit timer that increments based on clock input.

## Features
- 8-bit timer functionality
- Configurable clock input
- Overflow detection and interrupt flag (TMRIF)
- Reset and enable functionality
- External and internal clock selection

## Hardware & Software Requirements
- BASYS3 FPGA Board
- Xilinx Vivado for synthesis and simulation

## Functional Description
The TIMER0 module operates based on the selected clock source (clk_in or clk_ex) and increments the 8-bit counter when enabled (EN = 1). If the counter reaches 255 (0xFF), it resets to 0, sets the overflow flag (overflow), and asserts the interrupt flag (TMRIF). The timer can also be initialized with a specific value using DATA_init.

## Counter Behaviours
1. Reset (RESET = 1): Clears the counter and TMRIF flag.
2. Enable (EN = 1): Loads DATA_init into the counter.
3. Clock Event (m rising edge): Increments the counter unless overflow occurs.
4. Overflow (a = 255): Resets counter and sets TMRIF.

![Basys3](https://www.xilinx.com/content/dam/xilinx/imgs/prime/Basys3-Xilinx-1000x755.jpg)
