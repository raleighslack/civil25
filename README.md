# civil25 - An 8088 SBC

A 8088 based SBC. 512k of RAM. 256k of ROM.

This is a simple 8088 based SBC that is currently just in a testing phase. I do have plans to really work on this, make schematics, pcb's and everything else but currently I am just having some fun.

`../../../vasm/vasmx86_std -m8086 -Fbin test.s` can be used to compile vasm assembly files within the /software/vasm_testing/ folder  

Current assembler in use is NASM, working on making a way to create proper files for BCC/AS86  

Currently waiting on some CP80C88's to arrive for me to test with. Not sure that the current design works.  

**Update:**

CP80C88's have arrived, and I have done all of the address/data decoding, and have connected a ROM chip (SST39SF020A) to the CPU, and using the arduino monitor in `/software/arduino_monitors`, It all appears to be working correctly. Now I am going to work on the **Currently in progess** goals listed below.



## Current Parts List

- 1x 80c88 CPU
- 2x 74HC373 D-type Octal Latch
- 1x 74HC245 Bus Trancever
- 1x SST39SF020A Flash
- 1x 555 Clock Generator(And supporting circuitry)
- 100000x Jumper Wires

# Currently in progress
 - RAM
 - YM3812 + DAC
 - I/O Chip (82c55)
 - LCD (attached to 82c55)


# Future additions (Hardware)

- **ADD VIDEO CARD**
- Add SD Card
- PS/2 Keyboard/Mouse - Potentially using Shift Register + I/O Chip + Interrupt Chip
- PCB - Mini ITX - Compatible with ATX PSU's
- Potentially have some fun with SDRAM (probably not)
- Ethernet - Currently looking at the `W5100S-L`
- Real Time Clock

## Future Aditions (Software)

- C Compiler
- Make BIOS
- Make basic Kernel
- Make C Standard Library
- Make UNIX Operating System
