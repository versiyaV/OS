NASMFLAGS = -f elf64
GCCFLAGS = -std=c99 -mcmodel=large -ffreestanding -fno-stack-protector -mno-red-zone
LDFLAGS = -nostdlib -T link.lds
C_SRCS = main.c print.c

all: shell

buildObject:
	nasm $(NASMFLAGS) -o start.o start.asm
	gcc $(GCCFLAGS) -c $(C_SRCS)

shell: buildObject
	cd ../libc && ./build.sh
	ld $(LDFLAGS) -o user start.o main.o print.o ../bin/lib.a 
	objcopy -O binary user user.bin
	mv user.bin ../bin/user.bin
	rm -rf *.o user