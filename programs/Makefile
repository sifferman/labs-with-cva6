
AUX = -T aux/link.ld -I aux
BARE = -static -nostdlib -nostartfiles

all: examples/asm.s examples/c.c

%.elf: %.c
	riscv64-unknown-elf-gcc $< aux/program_stop.S -o $@ ${AUX} ${BARE}

%.elf: %.S
	riscv64-unknown-elf-gcc $< aux/program_stop.S -o $@ ${AUX} ${BARE}

clean:
	rm -rf *.elf **/*.elf
