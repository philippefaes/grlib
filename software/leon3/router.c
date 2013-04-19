/* Send 16 MB*64 descriptors of data from the AMBA port with the lowest index to the
   one with the highest, lowest+1 to highest-1 and so on. Requires an even number of
   AMBA ports. Memory is only allocated but not initialized and nothing is checked,
   this test is only for throughput. It requires 16 MB of memory for data and small
   additional part */ 

#include "testmod.h"
#include <stdlib.h>
#define MAXSIZE 1024

struct spwregs 
{
   volatile int ctrl;
   volatile int status;
   volatile int nodeaddr;
   volatile int clkdiv;
   volatile int destkey;
   volatile int time;
   volatile int unused[2];
   volatile int dmactrl;
   volatile int rxmaxlen;
   volatile int txdesc;
   volatile int rxdesc;
};

static int snoopen;

static char *almalloc(int sz)
{
        char *tmp;
        tmp = (char *) malloc(2*sz);
        tmp = (char *) (((int)tmp+sz) & ~(sz -1));
        return(tmp);
}

static inline int loadmem(int addr)
{
        int tmp;        
        if (snoopen) {
                asm volatile (" ld [%1], %0 "
                              : "=r"(tmp)
                              : "r"(addr)
                        );
        } else {
                asm volatile (" lda [%1]1, %0 "
                              : "=r"(tmp)
                              : "r"(addr)
                        );
        }
        return tmp;
}

static inline char loadb(int addr)
{
        char tmp;        
        if (snoopen) {
                asm volatile (" ldub [%1], %0 "
                              : "=r"(tmp)
                              : "r"(addr)
                        );
        } else {
                asm volatile (" lduba [%1]1, %0 "
                              : "=r"(tmp)
                              : "r"(addr)
                        );
        }
        return tmp;
}


int routertest(int addr, int addrinc, int ambaports, int spwports, int fifoports)
{
        int i;
        int j;
        int k;
        int *tmp;
        int *size;
        
        volatile char *buf;
        volatile int *rxd[ambaports];
        volatile int *txd[ambaports];
        volatile char *hdr[ambaports];
        
        struct spwregs *regs[ambaports];
        
        report_device(0x0108B000);
        snoopen = rsysreg(0) & (1 << 23);
        
        if (snoopen) report_subtest(SPW_SNOOP_TEST);
        else report_subtest(SPW_NOSNOOP_TEST);
        
        buf = (char *) malloc(MAXSIZE);
        
        for (i = 0; i < ambaports; i++) {
                regs[i] = (struct spwregs *) (addr + addrinc*i);
                rxd[i] = (int *) almalloc(1024);
                txd[i] = (int *) almalloc(1024);
                hdr[i] = malloc(2);
        }
        
        
        /*initiate registers*/
        for (i = 0; i < ambaports; i++) {
                regs[i]->ctrl = 0x2;
                regs[i]->status = 0xFFFFFFFF;
                regs[i]->nodeaddr = 0xFE;
                regs[i]->clkdiv = 0;
                regs[i]->destkey = 0;
                regs[i]->time = 0;
                regs[i]->dmactrl = 0x01E0;
                regs[i]->rxmaxlen = MAXSIZE+1;
                regs[i]->txdesc = (int) txd[i];
                regs[i]->rxdesc = (int) rxd[i];
        }
        
        for (i = 0; i < ambaports; i++) {
                for (j = 0; j < 64; j++) {
                        txd[i][j*4] = 0x1002;
                        txd[i][j*4+1] = (int)hdr[i];
                        txd[i][j*4+2] = MAXSIZE;
                        txd[i][j*4+3] = (int)buf;

                        rxd[i][j*2] = 0x2000000;
                        rxd[i][j*2+1] = (int)buf;
                }
                rxd[i][65*2] = 0;
                hdr[i][0] = spwports+ambaports-i;
                hdr[i][1] = 0xFE;
        }
        
        for (i = 0; i < ambaports; i++) {
                regs[i]->dmactrl = 0x19E3;
        }
        
        /* for (i = 0; i < ambaports; i++) { */
/*                 while((((loadmem((int)&regs[i]->dmactrl) >> 11) & 1))) {} */
/*         } */

        return 0;
}
