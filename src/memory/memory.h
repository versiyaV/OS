#ifndef _MEMORY_H_
#define _MEMORY_H_

#include "stdint.h"
#include "stddef.h"
#include "stdbool.h"

struct E820 {
    uint64_t address;   //base address of the memory region
    uint64_t length;    //lenght memory region
    uint32_t type;      //memory type
} __attribute__((packed));

struct FreeMemRegion {
    uint64_t address;
    uint64_t length;
};

struct Page{
    struct Page* next;
};

typedef uint64_t PDE;
typedef PDE* PD;
typedef PD* PDPTR;

#define PTE_P 1
#define PTE_W 2
#define PTE_U 4
#define PTE_ENTRY 0x80
#define KERNEL_BASE 0xffff800000000000
#define PAGE_SIZE (2*1024*1024)                         // 2 Mb
//align address up next page - shift right 21 bit and shift left clean up beats
#define PA_UP(v) ((((uint64_t)v + PAGE_SIZE-1) >> 21) << 21)
//align address down previous page 
#define PA_DOWN(v) (((uint64_t)v >> 21) << 21)

//converts between physical address to virtual on kernel
#define P2V(p) ((uint64_t)(p) + KERNEL_BASE)        //Physical address to virtual
#define V2P(v) ((uint64_t)(v) - KERNEL_BASE)       //Virtual address to physical

#define PDE_ADDR(p) (((uint64_t)p >> 12) << 12)
#define PTE_ADDR(p) (((uint64_t)p >> 21) << 21)

void* kalloc(void);
void kfree(uint64_t v);
void init_memory(void);
void init_kvm(void);
bool map_pages(uint64_t map, uint64_t v, uint64_t e, uint64_t pa, uint32_t attribute);
void switch_vm(uint64_t map);
void load_cr3(uint64_t map);
void free_vm(uint64_t map);
void free_page(uint64_t map, uint64_t v, uint64_t e);
bool setup_uvm(uint64_t map, uint64_t start, int size);
uint64_t setup_kvm(void);
uint64_t get_total_memory(void);
bool copy_uvm(uint64_t dst_map, uint64_t src_map, int size);

#endif