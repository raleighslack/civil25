PROGRAM = 8088rom
DEFINES += CPU_TYPE=86
LD = ia16-elf-ld
CC = ia16-elf-gcc
OBJCOPY = ia16-elf-objcopy

all: $(PROGRAM).o reset.o $(PROGRAM).elf out.bin dump.txt

$(PROGRAM).o: $(PROGRAM).asm
	nasm -f elf $(patsubst %,-D%,$(DEFINES)) -o $@ $<

reset.o: reset.asm
	nasm -f elf $(patsubst %,-D%,$(DEFINES)) -o $@ $<

$(PROGRAM).elf: $(PROGRAM).o reset.o
	$(LD) -T makefile.ld -Map=out.map --oformat=elf32-i386  $^ -o $@

out.bin: $(PROGRAM).elf
	$(OBJCOPY) -I elf32-little -O binary $< $@

dump.txt: $(PROGRAM).elf
	ia16-elf-objdump -D -m i8086 -M i8086,intel,intel-mnemonic $< > $@

clean:
	rm -f $(PROGRAM).o reset.o $(PROGRAM).elf out.bin dump.txt $(PROGRAM).map