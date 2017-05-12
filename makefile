CFLAGS= -m32 -nostdlib -fno-builtin -fno-exceptions -fno-leading-underscore
ASFLAGS= --32
LDFLAGS= -melf_i386

objects = loader.o kernel.o

%.o: %.c
	gcc -O0 -g $(CFLAGS) -c $< 

%.o: %.s
	as $(ASFLAGS) -o $@ $<

all: kernel.elf kernel.bin

kernel.elf: linker.ld $(objects)
	ld $(LDPARAMS) -T $< -o $@ $(objects)

run: kernel.iso
	qemu-system-i386 -gdb tcp::10000 -boot d -cdrom kernel.iso

kernel.bin: kernel.elf
	objcopy -O binary $< $@

kernel.iso : kernel.elf
	mkdir -p iso/boot/grub
	cp $< iso/boot
	echo "set timeout=0" >> iso/boot/grub/grub.cfg
	echo "set default=0" >> iso/boot/grub/grub.cfg
	echo "" >> iso/boot/grub/grub.cfg
	echo "menuentry \"Custom OS\" {" >> iso/boot/grub/grub.cfg
	echo "  multiboot /boot/$<" >> iso/boot/grub/grub.cfg
	echo "  boot" >> iso/boot/grub/grub.cfg
	echo "}" >> iso/boot/grub/grub.cfg
	grub-mkrescue --output=$@ iso
	rm -r iso

clean:
	rm -f *.o *.bin *.iso *.elf
