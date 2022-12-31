ENTRY(reset)

MEMORY
{
    ROM (rx) : ORIGIN = 0x00000, LENGTH = 256K
    tsegvma (wx) : ORIGIN = 0x00000, LENGTH = 256K
    dsegvma (wx) : ORIGIN = 0x00000, LENGTH = 256K
    bsegvma (rx) : ORIGIN = 0x3FFF0, LENGTH = 0x00010
}

SECTIONS
{
    .text : {
        __stext = ABSOLUTE(.);
        *(.startup)
        KEEP(*(.init))
        *(.text) *(.text.*)
        __etext = ABSOLUTE(.);
    } >tsegvma AT >ROM
    .data : {
        __sdata = ABSOLUTE(.);
        *(.rodata) *(.rodata.*)
        *(.data) *(.text.*)
        __edata = ABSOLUTE(.);
    } >dsegvma AT >ROM
    .bss (NOLOAD) : {
        __sbss = ABSOLUTE(.);
        *(.bss) *(.bss.*)
        __ebss = ABSOLUTE(.);
    } >dsegvma
    .resetvec : AT(0x3fff0){
        FILL(0x90);
        KEEP(*(.reset));
        . = 0x0000F;
        BYTE(0x90);
	}
    __dataoffset = LOADADDR(.data) - LOADADDR(.text);
    __ldata = SIZEOF(.data);
    __lbss = SIZEOF(.bss);
}