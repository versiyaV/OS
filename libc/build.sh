nasm -f elf64 -o syscall.o syscall.asm
gcc -std=c99 -mcmodel=large -ffreestanding -fno-stack-protector -mno-red-zone -c print.c
ar rcs lib.a print.o syscall.o
mv lib.a ../bin/
rm -rf print.o syscall.o