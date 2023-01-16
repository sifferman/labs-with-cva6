#
# File: Makefile
# Description: Makefile for compiling for CVA6.
#

AUX = -T aux/link.ld -I aux
BARE = -static -nostdlib -nostartfiles -fno-common -O0

all: clean examples/asm.elf examples/c.elf

# Create .elf from .c
%.elf: %.c
	riscv64-unknown-elf-gcc ${BARE} $< -o $@ ${AUX}

# Create .elf from .S
%.elf: %.S
	riscv64-unknown-elf-gcc ${BARE} $< -o $@ ${AUX}

clean:
	rm -rf *.elf **/*.elf


# Create .S from .c
%.S: %.c
	riscv64-unknown-elf-gcc -S -fverbose-asm ${BARE} $< -o $@ ${AUX}
