nasm -f elf64 -o start.o start.asm
gcc -std=c99 -mcmodel=large -ffreestanding -fno-stack-protector -mno-red-zone -c main.c
gcc -std=c99 -mcmodel=large -ffreestanding -fno-stack-protector -mno-red-zone -c print.c
ld -nostdlib -T link.lds -o user start.o main.o print.o ../bin/lib.a 
objcopy -O binary user test.bin
mv test.bin ../bin/test.bin
rm -rf *.o user