
# Graphical Game System Based on FPGA

## Overview
This project involves designing and implementing a multi-player **Pac-Man game** on an FPGA using **System Verilog HDL** and a **NIOS II SOC**. The system features pixel-level graphics processing, a custom GPU for handling game visuals, and software integration for managing gameplay logic and user interaction. The game graphics are stored in **SRAM** and displayed on a **VGA module**.

Key components include:
- **FPGA-based Game System**: Implements the game logic using System Verilog and the NIOS II SOC.
- **Graphics Processing Unit (GPU)**: Custom-designed GPU processes and renders pixel-level game graphics.
- **VGA Display**: The VGA module is used for outputting game visuals.
- **C-based Software Driver**: Developed the corresponding software driver and demo program to manage the game.

## Features
- **Multi-player Pac-Man**: Fully implemented Pac-Man game with multi-player functionality.
- **Graphics Rendering**: Designed pixel-level game graphics and implemented efficient processing using a custom GPU.
- **SRAM Integration**: Game graphics are pre-stored in **SRAM** and retrieved during gameplay.
- **VGA Display**: Game graphics are displayed using a **VGA module**, ensuring real-time rendering.
- **Software Driver and Demo**: Developed a driver in **C** to interact with the hardware and run the game.

## Installation and Setup
### Prerequisites
- **Quartus Prime**: FPGA development environment for compiling and deploying the System Verilog code.
- **NIOS II Embedded Design Suite (EDS)**: For SOC design and compiling the C software driver.
- **FPGA Board**: Ensure the FPGA board supports VGA output and has SRAM for graphics storage.
- **Monitor with VGA input**: Required for displaying the game visuals.

### Installation Steps
1. **Clone the Repository**:
   ```bash
   git clone <repository-url>
   cd graphical-game-system-fpga
   ```
2. **Open the Project in Quartus Prime**:
   - Launch **Quartus Prime** and open the project files.
   - Compile the System Verilog design for the Pac-Man game and GPU.
3. **Deploy the NIOS II SOC**:
   - Use the **NIOS II EDS** to compile the C-based software driver and demo.
   - Deploy the SOC and software driver onto the FPGA.
4. **Connect the VGA Display**:
   - Connect a VGA-compatible monitor to the FPGA board to display the game.

## Usage
Once the system is deployed on the FPGA, the game can be controlled using the inputs defined in the SOC. The gameplay and graphics will be displayed on the connected VGA monitor. Players can interact with the game through the inputs, and the graphics will be rendered in real-time.

## Hardware Components
- **FPGA Board**: Includes support for VGA output and an integrated NIOS II SOC.
- **SRAM**: Stores pre-loaded game graphics.
- **VGA Module**: Displays the game visuals.
- **Custom GPU**: Processes and outputs pixel-level graphics for the game.

## Future Improvements
- **Enhanced Graphics**: Add support for more detailed and higher-resolution graphics.
- **Audio Integration**: Implement sound effects and background music using an audio module.
- **Networked Multiplayer**: Expand the game to support networked multiplayer using Ethernet.
