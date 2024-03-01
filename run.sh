nasm -f bin main.asm -o main.bin
dd if=/dev/zero of=disk.img bs=512 count=20480
dd if=main.bin of=disk.img bs=512 seek=0 conv=notrunc
qemu-system-i386 -drive file=disk.img,format=raw
