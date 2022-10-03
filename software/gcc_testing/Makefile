DEFINES += CPU_TYPE=86
GCCFLAGS += -march=i8088 -mtune=i8088 -mcmodel=small $(patsubst %, -D%,$(DEFINES))
NASM = nasm
CC = ia16-elf-gcc
OBJCOPY = ia16-elf-objcopy
OBJDUMP = ia16-elf-objdump

all: main.o out.elf out.bin dump.txt lcd.o

main.o: main.c
	$(CC) $(GCCFLAGS) -c $<

lcd.o: lcd.asm
	$(NASM) -f elf $(patsubst %,-D%,$(DEFINES)) -o $@ $<

out.elf: main.o lcd.o
	$(CC) -Wall -g $^ -o $@

out.bin: out.elf
	$(OBJCOPY) -I elf32-little -O binary $< $@

dump.txt: out.bin
	$(OBJDUMP) -D -Mintel,i8086 -b binary -m i386 out.bin

clean:
	rm *.elf *.bin *.o
