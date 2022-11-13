# civil25 - An 8088 SBC

A 8088 based SBC. 512k of RAM. 256k of ROM.

This is a simple 8088 based SBC that doesnt aim for any kind of PC compatibility. This is just generally a project to learn about the 8088 and other processors.

Current assembler in use is NASM. I am working on the **Currently in progress** goals listed below, as well as software to support it along the way.

## Current Parts List

- 1x 80c88 CPU
- 2x 74HCT373 D-type Octal Latch
- 1x 74HCT245 Bus Trancever
- 2x 74HCT138 3-to-8 Decoder
- 1x SST39SF020A Flash
- 1x AS6C4008 RAM
- 1x 82c55A PPI
- 1x 82c59 PIC
- 1x 555/8284 Clock Generator(And supporting circuitry)
- 1x YM3812 FM Sound
- 1x TL072 Op-Amp
- 1x Y3014B DAC
- 1x LCD
- 100000x Jumper Wires

# Completed

- Base Computer
- 82c55 I/O plus LCD
- YM3812
- Schematics

# Currently in progress

- 82c59 Programmable Interrupt Controller
- PS/2 Keyboard
- Video Card using SCN2674B
- Add SD Card
- Real Time Clock + Battery

# Future additions (Hardware)

- PCB - Mini ITX - Compatible with ATX PSU's
- Ethernet - Currently looking at the `W5100S-L`
- DMA Controller (82c57)
- Timer (82c53/82c54)
- CMOS RAM to maintain system settings

## Future Aditions (Software)

- C Compiler
- Make BIOS
- Make Kernel
- Make C Standard Library
- Make UNIX Operating System
