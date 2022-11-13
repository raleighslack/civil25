DEFINES += CPU_TYPE=86
GCCFLAGS += -march=i8088 -mtune=i8088 -Os -mcmodel=small $(patsubst %, -D%,$(DEFINES))
NASM = nasm
CC = ia16-elf-gcc
OBJCOPY = ia16-elf-objcopy
OBJDUMP = ia16-elf-objdump
LD = ia16-elf-ld

all: main.o lcd.o out.elf out.bin reset.o dump.txt init.o

main.o: main.c
	$(CC) $(GCCFLAGS) -c $<

lcd.o: lcd.asm
	$(NASM) -f elf $(patsubst %,-D%,$(DEFINES)) -o $@ $<

reset.o: reset.asm
	$(NASM) -f elf $(patsubst %,-D%,$(DEFINES)) -o $@ $<

init.o: init.asm
	$(NASM) -f elf $(patsubst %,-D%,$(DEFINES)) -o $@ $<

out.elf: init.o main.o lcd.o reset.o 
	$(LD) -T makefile.ld -m elf_i386 -s $^ -o $@

out.bin: out.elf
	$(OBJCOPY) -I elf32-little -O binary $< $@

dump.txt: out.bin
	$(OBJDUMP) -D -Mintel,i8086 -b binary -m i386 out.bin > dump.txt

clean:
	rm *.elf *.bin *.o *.txt
