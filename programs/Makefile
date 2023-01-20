#
# File: Makefile
# Description: Makefile for compiling for CVA6.
#

AUX = -T aux/link.ld
BARE = -static -nostdlib -nostartfiles -march=rv64imafd -O0

all: clean examples/asm.elf bp/loop.elf bp/div.elf bp/spaghetti.elf

# Create .elf from .S
%.elf: %.S
	riscv64-unknown-elf-gcc ${BARE} $< ${AUX} -o $@

clean:
	rm -rf *.elf **/*.elf
