# UART Transmitter in Verilog HDL

## Overview

This project implements a parameterized UART (Universal Asynchronous Receiver/Transmitter) transmitter using Verilog HDL. The design uses a finite state machine (FSM) to transmit 8-bit serial data with configurable clock frequency and baud rate.

The design was simulated and synthesized using **Xilinx Vivado 2024.2** for an **Artix-7 FPGA**.

## Features

- FSM-based UART transmitter
- Configurable clock frequency and baud rate
- 8-bit serial data transmission
- Start bit and stop bit generation
- Least-significant-bit-first (LSB-first) transmission
- Transmitter busy (`tx_busy`) status signal
- Transmission completion (`tx_done`) pulse
- Verilog testbench for functional verification
- FPGA resource utilization analysis

## Design Specifications

| Parameter | Value |
|---|---|
| Hardware Description Language | Verilog HDL |
| Default clock frequency | 100 MHz |
| Default baud rate | 9600 |
| Data width | 8 bits |
| FPGA family | Artix-7 |
| Target device | `xc7a35tcpg236-1` |
| Development tool | Xilinx Vivado 2024.2 |
| Simulator | Vivado XSim |

## UART Frame Format

The UART transmitter sends data in the following format:

| Field | Description |
|---|---|
| Idle | Logic HIGH |
| Start bit | Logic LOW |
| Data bits | 8 bits, transmitted LSB first |
| Stop bit | Logic HIGH |

For example, the testbench transmits the byte `8'hA5`.

## Module Interface

| Signal | Direction | Description |
|---|---|---|
| `clk` | Input | System clock |
| `rst` | Input | Synchronous active-HIGH reset |
| `tx_start` | Input | Initiates data transmission |
| `tx_data[7:0]` | Input | 8-bit parallel data input |
| `tx` | Output | UART serial data output |
| `tx_busy` | Output | Indicates an ongoing transmission |
| `tx_done` | Output | One-clock-cycle transmission completion pulse |

## Simulation and Verification

The design was verified using a Verilog testbench in Vivado XSim behavioral simulation.

The testbench transmits the test byte `8'hA5` and checks the start bit, transmitted data, stop bit, and transmitter completion status.

**Simulation result:** `ALL UART TESTS PASSED`

The testbench uses reduced clock and baud-rate parameters to speed up simulation. The default parameters of the UART transmitter remain 100 MHz and 9600 baud.

### Simulation Console Results

<img width="1217" height="330" alt="image" src="https://github.com/user-attachments/assets/c6719095-3dbc-4d8b-a631-63aab6e3249a" />

### Simulation Waveform

<img width="1572" height="602" alt="image" src="https://github.com/user-attachments/assets/0b2cc050-fee1-42aa-9d58-2c0d0259c6e5" />

## Synthesis Results

The design was synthesized using Vivado for the Artix-7 FPGA target `xc7a35tcpg236-1`.

| Resource | Used | Available | Utilization |
|---|---:|---:|---:|
| LUT | 61 | 20,800 | 0.29% |
| Flip-Flops (FF) | 48 | 41,600 | 0.12% |
| I/O | 14 | 106 | 13.21% |

### FPGA Resource Utilization

<img width="1082" height="457" alt="image" src="https://github.com/user-attachments/assets/3fce5b90-170d-4a59-8aee-cfc102063c90" />


*Note: These figures are from the Vivado synthesis report. They do not, by themselves, establish timing closure or successful operation on physical hardware.*

## Project Structure

```text
UART-Transmitter-Verilog/
├── uart_tx.v
├── tb_uart_tx.v
├── README.md
└── Screenshots/
    ├── simulation_results.png
    ├── simulation_waveform.png
    └── synthesis_utilization.png
```

## How to Run the Project

1. Clone or download this repository.
2. Open Xilinx Vivado 2024.2.
3. Create or open a Verilog project targeting the appropriate Artix-7 device.
4. Add `uart_tx.v` under **Design Sources**.
5. Add `tb_uart_tx.v` under **Simulation Sources**.
6. Set `tb_uart_tx` as the simulation top module.
7. Run **Run Behavioral Simulation**.
8. Check the Tcl Console for `ALL UART TESTS PASSED`.

## Tools and Technologies

- Verilog HDL
- Xilinx Vivado 2024.2
- Vivado XSim behavioral simulator
- Artix-7 FPGA

## Key Learning Outcomes

- RTL design using Verilog HDL
- Finite state machine implementation
- UART serial communication protocol
- Parameterized hardware design
- Testbench development and functional verification
- FPGA synthesis and resource utilization analysis

## Author

**Kavin K K**

- - GitHub Profile: [@kavinkk0509](https://github.com/kavinkk0509)
- Project: UART Transmitter in Verilog HDL

---

*This project was developed as part of a digital design and RTL development portfolio.*
