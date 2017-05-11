CFLAGS= -m32 -nostdlib -lgcc -fno-builtin -fno-exceptions -fno-leading-underscore
ASFLAGS= --32
LDFLAGS= -melf_i386

objects = loader.o kernel.o

%.o: %.c
	gcc $(CFLAGS) -o $@ -c $<

%.o: %.s
	as $(ASFLAGS) -o $@ $<

customkernel.bin: linker.ld $(objects)
	ld $(LDPARAMS) -T $< -o $@ $(objects)

install: customkernel.bin
	cp $< /boot/$<

clean:
	rm *.o *.bin
