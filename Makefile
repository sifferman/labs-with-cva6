
LINK = -T link.ld
BARE = -static -nostdlib -nostartfiles

%.elf: %.c
	riscv64-unknown-elf-gcc $< -o $@ ${LINK} ${BARE}

%.elf: %.s
	riscv64-unknown-elf-gcc $< -o $@ ${LINK} ${BARE}
clean:
	rm -rf *.elf
