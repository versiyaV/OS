NASMFLAGS = -f elf64
GCCFLAGS = -std=c99 -mcmodel=large -ffreestanding -fno-stack-protector -mno-red-zone
LDFLAGS = -nostdlib -T link.lds

C_SRCS = main.c print.c debug.c file.c

all: loader

buildObject:
	nasm -f bin -o loader.bin loader.asm
	nasm $(NASMFLAGS) -o entry.o entry.asm
	nasm $(NASMFLAGS) -o liba.o lib.asm
	gcc $(GCCFLAGS) -c $(C_SRCS)

loader: buildObject
	ld $(LDFLAGS) -o entry entry.o main.o liba.o print.o debug.o file.o
	objcopy -O binary entry entry.bin
	dd if=entry.bin >> loader.bin
	dd if=loader.bin of=../bin/os.img bs=512 count=15 seek=1 conv=notrunc
	rm -rf *.o *.bin entry 