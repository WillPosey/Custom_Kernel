#include <stdint.h>


void printf(char *str)
{

}


void kernel_main(void* multiboot, uint32_t magic)
{
    printf("Hello, world!\r\n");        
}
