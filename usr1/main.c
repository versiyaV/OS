#include "lib.h"

int main(void)
{
    int pid;

    pid = fork();
    if (pid == 0) 
    {
        exec("TEST.BIN");
    }
    else 
    {
        waitu(pid);
        printf("test process exit\n");
    }
    
    return 0;
}