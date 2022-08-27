# civil25 - An 8088 SBC

A 8088 based SBC. 512k of RAM. 256k of ROM.

This is a simple 8088 based SBC that is currently just in a testing phase. I do have plans to really work on this, make schematics, pcb's and everything else but currently I am just having some fun.

`../../../vasm/vasmx86_std -m8086 -Fbin test.s` can be used to compile vasm assembly files within the /software/vasm_testing/ folder

Currently waiting on some CP80C88's to arrive for me to test with. Not sure that the current design works.

## Current Parts List

- 1x 80c88 CPU
- 2x 74HC373 D-type Octal Latch
- 1x 74HC245 Bus Trancever
- 1x SST39SF020A Flash
- 100000x Jumper Wires

# Future additions (Hardware)

- Sound Chip - YM3812
- Add SD Card Interface
- PS/2 Keyboard/Mouse
- PCB/Case
- VGA Video Card(maybe an FPGA?)
- Potentially have some fun with SDRAM
- Ethernet (Maybe 10 Megabit)
- Real Time Clock

## Future Aditions (Software)

- C Compiler
- Make BIOS
- Make basic Kernel
- Make C Standard Library
- Make UNIX Operating System
