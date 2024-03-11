#compile
nasm -f elf64 -o kernel.o src/loader/kernel/kernel.asm
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
gcc -std=c99 -mcmodel=large -ffreestanding -fno-stack-protector -mno-red-zone -c src/filesystem/file.c 
ld -nostdlib -T src/link.lds -o kernel kernel.o main.o trapa.o trap.o liba.o print.o debug.o memory.o process.o syscall.o lib.o keyboard.o file.o
objcopy -O binary kernel kernel.bin 


#post build
if ! test -d bin/; then
mkdir bin
fi
mv kernel.bin bin/
rm -rf *.bin *.o kernel