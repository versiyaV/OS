#compile
nasm -f bin -o boot.bin src/loader/boot.asm
nasm -f bin -o loader.bin src/loader/loader.asm
nasm -f elf64 -o kernel.o src/loader/kernel.asm
nasm -f elf64 -o trapa.o src/interrupts/trap.asm
nasm -f elf64 -o liba.o src/lib/lib.asm
gcc -std=c99 -mcmodel=large -ffreestanding -fno-stack-protector -mno-red-zone -c src/main.c
gcc -std=c99 -mcmodel=large -ffreestanding -fno-stack-protector -mno-red-zone -c src/interrupts/trap.c
gcc -std=c99 -mcmodel=large -ffreestanding -fno-stack-protector -mno-red-zone -c src/lib/print.c
gcc -std=c99 -mcmodel=large -ffreestanding -fno-stack-protector -mno-red-zone -c src/lib/debug.c
gcc -std=c99 -mcmodel=large -ffreestanding -fno-stack-protector -mno-red-zone -c src/lib/lib.c  
gcc -std=c99 -mcmodel=large -ffreestanding -fno-stack-protector -mno-red-zone -c src/memory/memory.c 
gcc -std=c99 -mcmodel=large -ffreestanding -fno-stack-protector -mno-red-zone -c src/processes/process.c
gcc -std=c99 -mcmodel=large -ffreestanding -fno-stack-protector -mno-red-zone -c src/processes/syscall.c
gcc -std=c99 -mcmodel=large -ffreestanding -fno-stack-protector -mno-red-zone -c src/drivers/keyboard/keyboard.c 
ld -nostdlib -T src/link.lds -o kernel kernel.o main.o trapa.o trap.o liba.o print.o debug.o memory.o process.o syscall.o lib.o keyboard.o
objcopy -O binary kernel kernel.bin 

#build
dd if=boot.bin of=boot.img bs=512 count=1 conv=notrunc
dd if=loader.bin of=boot.img bs=512 count=5 seek=1 conv=notrunc
dd if=kernel.bin of=boot.img bs=512 count=100 seek=6 conv=notrunc
dd if=bin/user1.bin of=boot.img bs=512 count=10 seek=106 conv=notrunc
dd if=bin/user2.bin of=boot.img bs=512 count=10 seek=116 conv=notrunc
dd if=bin/user3.bin of=boot.img bs=512 count=10 seek=126 conv=notrunc
truncate boot.img --size=100M

#post build
rm -rf *.bin *.o kernel
if ! test -d bin/; then
mkdir bin
fi
mv boot.img bin/