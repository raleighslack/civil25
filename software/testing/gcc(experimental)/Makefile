DEFINES += CPU_TYPE=86
GCCFLAGS += -march=i8088 -mtune=i8088 -mcmodel=small $(patsubst %, -D%,$(DEFINES))
NASM = nasm
CC = ia16-elf-gcc
OBJCOPY = ia16-elf-objcopy
OBJDUMP = ia16-elf-objdump
CXX = ia16-elf-g++
LD = ia16-elf-ld
LIBS += c nosys

all: main.o lcd.o out.elf out.bin reset.o init.o int_vect.o utils.o key8242.o dump.txt

main.o: main.c
	$(CC) $(GCCFLAGS) $(patsubst %,-l%,$(LIBS)) -std=c11 -D_DEFAULT_SOURCE -I ./ -c -o $@ $< 

lcd.o: lcd.asm
	$(NASM) -f elf $(patsubst %,-D%,$(DEFINES)) -o $@ $<

reset.o: reset.asm
	$(NASM) -f elf $(patsubst %,-D%,$(DEFINES)) -o $@ $<

init.o: init.asm
	$(NASM) -f elf $(patsubst %,-D%,$(DEFINES)) -o $@ $<

int_vect.o: int_vect.asm
	$(NASM) -f elf $(patsubst %,-D%,$(DEFINES)) -o $@ $<

utils.o: utils.asm
	$(NASM) -f elf $(patsubst %,-D%,$(DEFINES)) -o $@ $<

key8242.o: key8242.asm
	$(NASM) -f elf $(patsubst %,-D%,$(DEFINES)) -o $@ $<

out.elf: init.o main.o lcd.o reset.o utils.o int_vect.o key8242.o
	$(CXX) -T makefile.ld -nostartfiles -Wl,-Map=out.map -Wl,--gc-sections -Wl,--oformat=elf32-i386 $(patsubst %,-l%,$(LIBS)) -o $@ $^ 

out.bin: out.elf
	$(OBJCOPY) -I elf32-little -O binary $< $@

dump.txt: out.elf
	$(OBJDUMP) -D -m i8086 -M i8086,intel,intel-mnemonic $< > $@

clean:
	rm *.elf *.bin *.o *.txt *.map *.s
