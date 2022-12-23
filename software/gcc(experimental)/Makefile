DEFINES += CPU_TYPE=86
GCCFLAGS += -march=i8088 -mtune=i8088 -mcmodel=small $(patsubst %, -D%,$(DEFINES))
NASM = nasm
CC = ia16-elf-gcc
OBJCOPY = ia16-elf-objcopy
OBJDUMP = ia16-elf-objdump
LD = ia16-elf-ld
LIBS += c

all: main.o lcd.o out.elf out.bin reset.o init.o dump.txt

main.o: main.c
	$(CC) $(GCCFLAGS) $(patsubst %,-l%,$(LIBS)) -std=c11 -D_DEFAULT_SOURCE -I ./ -c $< -o $@

lcd.o: lcd.asm
	$(NASM) -f elf $(patsubst %,-D%,$(DEFINES)) -o $@ $<

reset.o: reset.asm
	$(NASM) -f elf $(patsubst %,-D%,$(DEFINES)) -o $@ $<

init.o: init.asm
	$(NASM) -f elf $(patsubst %,-D%,$(DEFINES)) -o $@ $<

out.elf: init.o main.o lcd.o reset.o
	$(CC) -T makefile.ld -nostartfiles -fno-use-cxa-atexit -Wl,-Map=out.map -Wl,--oformat=elf32-i386 $(patsubst %,-l%,$(LIBS))  -s $^ -o $@

out.bin: out.elf
	$(OBJCOPY) -I elf32-little -O binary $< $@

dump.txt: out.elf
	$(OBJDUMP) -d -S -Mintel,i8086 -s -m i8086 $< > $@

clean:
	rm *.elf *.bin *.o *.txt *.map *.s
