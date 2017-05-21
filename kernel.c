#include <stdint.h>
#include "multiboot.h"


void printf(char *str)
{
    int i;
    volatile uint16_t *videomem = (uint16_t*) 0xb8000;
    for(i=0; str[i] != '\0'; i++){
        videomem[i] = 0x0700 | str[i];
    }
}


/*
 * Per the spec
 *  - eax contains an adjusted magic
 *  - ebc contains a 32-bit pointer to the multiboot information structure
 */
void kernel_main(struct multiboot_info* mbi, uint32_t magic_adj)
{
    if(MULTIBOOT_BOOTLOADER_MAGIC == magic_adj){
        printf("Hello, World!");
    }else
        printf("Something went wrong!");
}
