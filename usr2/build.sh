nasm -f elf64 -o start.o start.asm
gcc -std=c99 -mcmodel=large -ffreestanding -fno-stack-protector -mno-red-zone -c main.c
ld -nostdlib -T link.lds  -o user start.o main.o ../bin/lib.a
objcopy -O binary user user.bin
mv user.bin ../bin/user2.bin
rm -rf main.o start.o user