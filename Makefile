NASMFLAGS = -f elf64
GCCFLAGS = -std=c99 -mcmodel=large -ffreestanding -fno-stack-protector -mno-red-zone
LDFLAGS = -nostdlib -T src/link.lds

C_SRCS = src/main.c src/interrupts/trap.c src/lib/print.c src/lib/debug.c src/lib/lib.c src/memory/memory.c src/processes/process.c src/processes/syscall.c src/drivers/keyboard/keyboard.c src/filesystem/file.c

all: kernel

buildAsmObjects:
	nasm $(NASMFLAGS) -o kernel.o src/loader/kernel/kernel.asm
	nasm $(NASMFLAGS) -o trapa.o src/interrupts/trap.asm
	nasm $(NASMFLAGS) -o liba.o src/lib/lib.asm

buildObject: buildAsmObjects
	gcc $(GCCFLAGS) -c $(C_SRCS)

# Target
kernel: buildObject
	ld $(LDFLAGS) -o kernel *.o
	objcopy -O binary kernel kernel.bin
	mkdir -p bin
	mv kernel.bin bin/
	rm -rf *.bin *.o kernel

loader: src/loader
	cd loader && make

shell: kernel
	cd shell && make

totalmem: kernel
	cd totalmem && make

ls: kernel
	cd ls && make

# Clean target
clean:
	rm -rf bin/