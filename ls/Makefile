NASMFLAGS = -f elf64
GCCFLAGS = -std=c99 -mcmodel=large -ffreestanding -fno-stack-protector -mno-red-zone
LDFLAGS = -nostdlib -T link.lds
C_SRCS = main.c

all: ls

buildObject:
	nasm $(NASMFLAGS) -o start.o start.asm
	gcc $(GCCFLAGS) -c $(C_SRCS)

ls: buildObject
	cd ../libc && ./build.sh
	ld $(LDFLAGS) -o user *.o ../bin/lib.a 
	objcopy -O binary user ls
	mv ls ../bin/ls
	rm -rf *.o user