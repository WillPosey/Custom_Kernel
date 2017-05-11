.set BL_MAGIC, 0x1BADB002
.set FLAGS, (1<<0 | 1<<1)
.set CHECKSUM, -(BL_MAGIC + FLAGS)


# Magic for bootloader to recognize our image
.section .multiboot
    .long BL_MAGIC
    .long FLAGS
    .long CHECKSUM


.section .text
.extern kernel_main
.global loader

# Bootloader copies multiboot pointer to EAX and magic number to EBX
loader:
    mov $kernel_stack, %esp
    push %eax   # Push to the stack for bookkeeping
    push %ebx
    call kernel_main

_stop:
    cli
    hlt
    jmp _stop


.section .bss
.space 2*1024*1024; #2MiB for stack
kernel_stack:

