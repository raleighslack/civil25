PROGRAM = 8088rom
DEFINES += CPU_TYPE=86
LD = ia16-elf-ld
OBJCOPY = ia16-elf-objcopy


all: $(PROGRAM).o reset.o $(PROGRAM).elf out.bin dump.txt

$(PROGRAM).o: $(PROGRAM).asm
	nasm -f elf $(patsubst %,-D%,$(DEFINES)) -o $@ $<

reset.o: reset.asm
	nasm -f elf $(patsubst %,-D%,$(DEFINES)) -o $@ $<

$(PROGRAM).elf: $(PROGRAM).o reset.o
	$(LD) -T makefile.ld -Map=$(PROGRAM).map -m elf_i386 -s $^ -o $@

out.bin: $(PROGRAM).elf
	$(OBJCOPY) -I elf32-little -O binary $< $@

dump.txt: out.bin
	ia16-elf-objdump -D -Mintel,i8086 -b binary -m i386 $< > $@

clean:
	rm -f $(PROGRAM).o reset.o $(PROGRAM).elf out.bin dump.txt $(PROGRAM).map