#!/bin/bash

echo "building kernel binaries"
nasm -f bin -o kernel.bin kernel.asm

echo "building iso"
dd status=noxfer conv=notrunc if=kernel.bin of=os.iso
