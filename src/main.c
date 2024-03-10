#include "interrupts/trap.h"
#include "lib/print.h"
#include "lib/debug.h"
#include "memory/memory.h"
#include "processes/process.h"
#include "processes/syscall.h"

void KMain()
{ 
    init_idt();
    init_memory();
    init_kvm();
    init_system_call();
    init_process();
    launch();
}