.intel_syntax noprefix
.set MAGIC,                 0x1badb002 
.set BOOT_MODULES_ALIGNED,  (1<<0)
.set MEMINFO,               (1<<1)  
.set VIDEOINFO,             (0<<2)  # Graphics fields of the multiboot header
.set FLAGS,                 (BOOT_MODULES_ALIGNED | MEMINFO | VIDEOINFO)
.set CHECKSUM,              -(MAGIC + FLAGS)
.set STACK_SIZE,            2*2014*1024

.extern kernel_main         # Extern to be seen from _this_ file at link-time
.global kernel_loader       # Made global to be seen at link-time


# GRUB(legacy/2) can boot mutliboot-compatible kernels; make us compatible
.section .multiboot
    .long MAGIC
    .long FLAGS
    .long CHECKSUM


.section .text
kernel_loader:
    mov esp, kernel_stack
    push eax
    push ebx
    call kernel_main

_exit_loop:
    cli
    hlt
    jmp _exit_loop


.section .bss
.align 4            # Stack is word-aligned
.space STACK_SIZE   # 2MiB for stack
kernel_stack:       # Stack grows up from here?
