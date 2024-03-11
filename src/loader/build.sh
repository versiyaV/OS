nasm -f bin -o loader.bin loader.asm
nasm -f elf64 -o entry.o entry.asm
nasm -f elf64 -o liba.o kernel/lib.asm
gcc -std=c99 -mcmodel=large -ffreestanding -fno-stack-protector -mno-red-zone -c main.c 
gcc -std=c99 -mcmodel=large -ffreestanding -fno-stack-protector -mno-red-zone -c ../lib/print.c 
gcc -std=c99 -mcmodel=large -ffreestanding -fno-stack-protector -mno-red-zone -c ../lib/debug.c 
gcc -std=c99 -mcmodel=large -ffreestanding -fno-stack-protector -mno-red-zone -c kernel/file.c 
ld -nostdlib -T link.lds -o entry *.o
objcopy -O binary entry entry.bin
dd if=entry.bin >> loader.bin
dd if=loader.bin of=../os.img bs=512 count=15 seek=1 conv=notrunc

rm -rf *.o *.bin entry