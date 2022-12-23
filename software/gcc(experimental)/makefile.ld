ENTRY(reset)

MEMORY
{
    ROM (rx) : ORIGIN = 0x00000, LENGTH = 256K
    tsegvma (wx) : ORIGIN = 0x00000, LENGTH = 256K
    dsegvma (wx) : ORIGIN = 0x00000, LENGTH = 256K
}

SECTIONS
{
    .text : {
        __stext = .;
        *(.startup)
        KEEP(*(.init))
        *(.text) *(.text.*)
        __etext = .;
    } >tsegvma AT >ROM
    .data : {
        __sdata = .;
        *(.rodata) *(.rodata.*)
        *(.data) *(.text.*)
        __edata = .;
    } >dsegvma AT >ROM
    .bss (NOLOAD) : {
        __sbss = .;
        *(.bss) *(.bss.*)
        __ebss = .;
    } >dsegvma
    .reset : AT(0x3FFF0) {
        FILL(0x90)
        KEEP(*(.reset));
        . = 0x000f;
        BYTE(0x90)
    }
    __dataoffset = LOADADDR(.data) - LOADADDR(.text);
    __ldata = __edata - __sdata;
    __lbss = __ebss - __sbss;
}