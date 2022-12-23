PROGRAM = 8088rom
DEFINES += CPU_TYPE=86
LD = ia16-elf-ld
CC = ia16-elf-gcc
OBJCOPY = ia16-elf-objcopy
LIBS +=


all: $(PROGRAM).o reset.o $(PROGRAM).elf out.bin dump.txt

$(PROGRAM).o: $(PROGRAM).asm
	nasm -f elf $(patsubst %,-D%,$(DEFINES)) -o $@ $<

reset.o: reset.asm
	nasm -f elf $(patsubst %,-D%,$(DEFINES)) -o $@ $<

$(PROGRAM).elf: $(PROGRAM).o reset.o
	$(CC) -T makefile.ld -nostartfiles -Wl,-Map=out.map -Wl,--oformat=elf32-i386 $(patsubst %,-l%,$(LIBS)) $^ -o $@

out.bin: $(PROGRAM).elf
	$(OBJCOPY) -I elf32-little -O binary $< $@

dump.txt: out.bin
	ia16-elf-objdump -D -Mintel,i8086 -b binary -m i386 $< > $@

clean:
	rm -f $(PROGRAM).o reset.o $(PROGRAM).elf out.bin dump.txt $(PROGRAM).map