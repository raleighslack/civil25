ENTRY(reset)

MEMORY
{
    RAM (rwx) : ORIGIN = 0x00000, LENGTH = 512K
    ROM (rx) : ORIGIN = 0xC0000, LENGTH = 256K
}

SECTIONS
{
    .text : AT(0x00000) {
        KEEP(*(.init))
        *(.text) *(.text.*)
    }
    .reset : AT(0x3FFF0) {
        FILL(0x90);
        KEEP(*(.reset));
        . = 0x000f;
        BYTE (0x90)
    }
}