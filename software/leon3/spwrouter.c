/* To run this test the router has to have at least one AMBA port and all 
   spw and fifo ports have to be placed in loopback in the testbench */

#include "testmod.h"
#include <stdlib.h>

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

struct rtrcfgregs
{
   volatile int portsetup[256];
   volatile int routingtable[256];
   volatile int portcontrol[32];
   volatile int portstatus[32];
   volatile int reload[32];
   volatile int unused[32];
   volatile int rtrcfg;
   volatile int timecode;
   volatile int verinstid;
   volatile int initdivisor;
   volatile int cfgwen;
   volatile int charout[32];
   volatile int charin[32];
   volatile int pktout[32];
   volatile int pktin[32];
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

int spwrouter_test_udel(int ahbslv, int ahbslvaddr, int nbrofdma, int *dmaaddr, int udel)
{
        int i;
        int j;
        int k;
        int l;
        int rmapaddr;
        int tmp;
        int tmp2;
        int *tmp3;
        int *size;
        int nbrofspw;
        int nbroffifo;
        
        volatile char **rx;
        volatile char **tx;
        volatile char *rmap;
        volatile char *rmaphdr;
        volatile int **rxd;
        volatile int **txd;
        
        struct spwregs *regs[nbrofdma];
        struct rtrcfgregs *cfgregs;
        
        report_device(0x0108B000);
        snoopen = rsysreg(0) & (1 << 23);
        
        if (snoopen) report_subtest(SPW_SNOOP_TEST);
        else report_subtest(SPW_NOSNOOP_TEST);

        for (i = 0; i < nbrofdma; i++) {
                regs[i] = (struct spwregs *)dmaaddr[i];
        }

        /* test a few accesses to the configuration area through
           the ahb slave interface */
        if (ahbslv == 1) {
                cfgregs = (struct rtrcfgregs *)ahbslvaddr;
                /* Check router configuration and status register*/ 
                tmp = loadmem((int)&cfgregs->rtrcfg);
                if (((tmp >> 22) & 0x1F) != nbrofdma) {
                        fail(1);
                }
                nbrofspw = (tmp >> 27) & 0x1F;
                nbroffifo = (tmp >> 17) & 0x1F;
                /* Port setup */ 
                cfgregs->portsetup[1] = 1;
                tmp = loadmem((int)&cfgregs->portsetup[1]);
                if (tmp != 1) {
                        fail(2);
                }
                cfgregs->portsetup[1] = 0;
                tmp = loadmem((int)&cfgregs->portsetup[1]);
                if (tmp != 0) {
                        fail(3);
                }
                cfgregs->portsetup[127] = 1;
                tmp = loadmem((int)&cfgregs->portsetup[127]);
                if (tmp != 1) {
                        fail(4);
                }
                cfgregs->portsetup[127] = 0;
                tmp = loadmem((int)&cfgregs->portsetup[127]);
                if (tmp != 0) {
                        fail(5);
                }
                cfgregs->portsetup[255] = 1;
                tmp = loadmem((int)&cfgregs->portsetup[255]);
                if (tmp != 1) {
                        fail(6);
                }
                cfgregs->portsetup[255] = 0;
                tmp = loadmem((int)&cfgregs->portsetup[255]);
                if (tmp != 0) {
                        fail(7);
                }
                /* Routing table */ 
                cfgregs->routingtable[1] = 1;
                tmp = loadmem((int)&cfgregs->routingtable[1]);
                if (tmp != 1) {
                        fail(8);
                }
                cfgregs->routingtable[1] = 0;
                tmp = loadmem((int)&cfgregs->routingtable[1]);
                if (tmp != 0) {
                        fail(9);
                }
                cfgregs->routingtable[127] = 1;
                tmp = loadmem((int)&cfgregs->routingtable[127]);
                if (tmp != 1) {
                        fail(10);
                }
                cfgregs->routingtable[127] = 0;
                tmp = loadmem((int)&cfgregs->routingtable[127]);
                if (tmp != 0) {
                        fail(11);
                }
                cfgregs->routingtable[255] = 1;
                tmp = loadmem((int)&cfgregs->routingtable[255]);
                if (tmp != 1) {
                        fail(12);
                }
                cfgregs->routingtable[255] = 0;
                tmp = loadmem((int)&cfgregs->routingtable[255]);
                if (tmp != 0) {
                        fail(13);
                }
                /* initdivisor */
                tmp = loadmem((int)&cfgregs->initdivisor);
                
                /* Port control/status */ 
                for (i = 1; i <= nbrofspw+nbrofdma+nbroffifo; i++) {
                        if (i <= nbrofspw) {
                                tmp2 = loadmem((int)&cfgregs->portcontrol[i]);
                                if (tmp != ((tmp2 >> 24) & 0xFF)) {
                                        fail(14);
                                }
                        }
                        tmp2 = loadmem((int)&cfgregs->portstatus[i]);
                        if (i <= nbrofspw) {
                                if (((tmp2 >> 30) & 3) != 0) {
                                        fail(15);
                                } 
                        } else if (i <= nbrofspw+nbrofdma) {
                                if (((tmp2 >> 30) & 3) != 1) {
                                        fail(16);
                                } 
                        } else if (i <= nbrofspw+nbrofdma+nbroffifo) {
                                if (((tmp2 >> 30) & 3) != 2) {
                                        fail(17);
                                } 
                        }
                }
        }
        
        rmaphdr = malloc(8);
        rmap = malloc(64);
        rxd = malloc(nbrofdma*sizeof(int **));
        txd = malloc(nbrofdma*sizeof(int **));
        rx = malloc((nbrofspw+nbroffifo)*sizeof(char **));
        tx = malloc((nbrofspw+nbroffifo)*sizeof(char **));
        size = (int *) malloc(sizeof(int));
        for (i = 0; i < nbrofdma; i++) {
                rxd[i] = (int *) almalloc(1024);
                txd[i] = (int *) almalloc(1024);
        }
        
        for (i = 0; i < nbrofspw+nbroffifo; i++) {
                rx[i] = malloc(32);
                tx[i] = malloc(32);
        }

        /*reset link */
        for (i = 0; i < nbrofdma; i++) {
                regs[i]->ctrl = (1 << 6);
                for (j = 0; j < 10; j++) {}
                
                regs[i]->status = 0xFFFFFFFF;
                regs[i]->nodeaddr = i+1;
                regs[i]->destkey = 0;
                regs[i]->time = 0;
                regs[i]->dmactrl = 0x01E0;
                regs[i]->rxmaxlen = 1024;
                regs[i]->txdesc = (int) txd[i];
                regs[i]->rxdesc = (int) rxd[i];
        }
        
        /* enable spacewire links */
        for (i = 1; i <= nbrofspw; i++) {
                tmp = loadmem((int)&cfgregs->portcontrol[i]);
                cfgregs->portcontrol[i] = ((tmp & 0xFFFFFFF8) | 2);
        }
        
        for (i = 1; i <= nbrofspw; i++) {
                while(((loadmem((int)&cfgregs->portstatus[i]) >> 12) & 7) != 5) {}
        }
        
        /* initialize buffers */
        for (j = 0; j < nbrofdma; j++) {
                for (i = 0; i < 32; i++) {
                        rx[j][i] = 0;
                }
                for (i = 0; i < 32; i++) {
                        tx[j][i] = 0;
                }
                for (i = 0; i < 32; i++) {
                        rmap[i] = 0;
                }
                for (i = 0; i < 32; i++) {
                        rmaphdr[i] = 0;
                }
                for (i = 0; i < 4*(nbrofspw+nbroffifo); i++) {
                        txd[j][i] = 0;
                }
                for (i = 0; i < 4*(nbrofspw+nbroffifo); i++) {
                        rxd[j][i] = 0;
                }
        }
        
        /* use amba ports to transfer packet through all ports */
        j = 0; l = 0;
        for (i = 1; i <= nbrofspw+nbroffifo; i++) {
                for(k = 3; k < 32; k++) {
                        tx[i-1][k] = (char) (k+i*4);
                }
                tx[i-1][0] = (char) i;
                tx[i-1][1] = (char) nbrofspw+j+1;
                tx[i-1][2] = (char) j+1;
                
                rxd[j][1+l*2] = (int) rx[i-1];
                rxd[j][0+l*2] = (1 << 25);
                
                txd[j][3+l*4] = (int)tx[i-1];
                txd[j][2+l*4] = 32;
                txd[j][1+l*4] = 0;
                txd[j][0+l*4] = (1 << 12);

                if (j < nbrofdma-1) {
                        j++;
                } else {
                        j = 0; l++;
                }
        }
        
        for (i = 0; i < nbrofdma; i++) {
                regs[i]->dmactrl = 0x19E3;
        }
        
        j = 0; l = 0;
        for (i = 1; i <= nbrofspw+nbroffifo; i++) {
                while((loadmem((int)&rxd[j][0+l*2]) >> 25) & 1) {}
                if (!((loadmem((int)&regs[j]->dmactrl) >> 6) & 1)) {
                        fail(18);
                }
                if (!((loadmem((int)&regs[j]->dmactrl) >> 5) & 1)) {
                        fail(19);
                }
                if ((loadmem((int)&regs[j]->dmactrl) & 1)) {
                        fail(20);
                }
                for(k = 0; k < 30; k++) {
                        if (loadb((int)&rx[i-1][k]) != tx[i-1][k+2]) {
                                fail(21);
                        }
                }
                if (j < nbrofdma-1) {
                        j++;
                } else {
                        j = 0; l++;
                }
        }
        
        /*Enable self-addressing*/
        tmp = loadmem((int)&cfgregs->rtrcfg);
        cfgregs->rtrcfg = tmp | (1 << 4);
        
        /*check rmap target in AMBA ports*/
        rmapaddr = (int) rmap;
        for (j = 0; j < nbrofdma; j++) {
                if ((loadmem((int)&regs[j]->ctrl) >> 31) & 1) {
                        report_subtest(SPW_RMAP_TEST);
                        regs[j]->ctrl = loadmem((int)&regs[j]->ctrl) | (1 << 16);
                        rmaphdr[0] = nbrofspw+j+1;
                        rmaphdr[1] = j+1;
                        rmaphdr[2] = 1;
                        rmaphdr[3] = 0x6D;
                        rmaphdr[4] = 0;
                        rmaphdr[5] = 0;
                        rmaphdr[6] = 0;
                        rmaphdr[7] = 0;
                        rmaphdr[8] = nbrofspw+j+1;
                        rmaphdr[9] = j+1;
                        rmaphdr[10] = 0;
                        rmaphdr[11] = 0;
                        rmaphdr[12] = 0;
                        rmaphdr[13] = (rmapaddr >> 24) & 0xFF;
                        rmaphdr[14] = (rmapaddr >> 16) & 0xFF;
                        rmaphdr[15] = (rmapaddr >> 8) & 0xFF;
                        rmaphdr[16] = rmapaddr & 0xFF;
                        rmaphdr[17] = 0;
                        rmaphdr[18] = 0;
                        rmaphdr[19] = 64;

                        for (k = 0; k < 64; k++) {
                                tx[j][k] = k;
                        }
                        
                        rxd[j][1+l*2] = (int)rx[j];
                        rxd[j][0+l*2] = (1 << 26) | (1 << 25);

                        txd[j][3+l*4] = (int) tx[j];
                        txd[j][2+l*4] = 64;
                        txd[j][1+l*4] = (int) rmaphdr;
                        txd[j][0+l*4] = (1 << 13) | (1 << 12) | 20 | (1 << 16) | (1 << 17) | (1 << 8);
                        regs[j]->dmactrl = 0x19E3;
                        
                        while((loadmem((int)&rxd[j][0+l*2]) >> 25) & 1) {}
                        
                        for(k = 0; k < 64; k++) {
                                if (loadb((int)&rmap[k]) != tx[j][k]) {
                                        fail(22);
                                }
                        }
                        
                        rmaphdr[0] = j+1;
                        rmaphdr[1] = 1;
                        rmaphdr[2] = 0x2D;
                        rmaphdr[3] = 0;
                        rmaphdr[4] = j+1;
                        rmaphdr[5] = 0;
                        rmaphdr[6] = 0;
                        
                        if ((loadmem((int)&rxd[j][0+l*2]) & 0x1FFFFFF) != 8) {
                                fail(23);
                        }
                        
                        for(k = 0; k < 7; k++) {
                                if (loadb((int)&rx[j][k]) != rmaphdr[k]) {
                                        fail(24);
                                }
                        }
                }
        }
        
        
        /*check time interface*/
        report_subtest(SPW_TIME_TEST);
        for (j = 0; j < nbrofdma; j++) {
                regs[j]->ctrl = loadmem((int)&regs[j]->ctrl) | (1 << 11) | (1 << 10);
                for (i = 0; i < nbrofdma; i++) {
                        regs[i]->time = 0;
                }
        }

        cfgregs->timecode = (3 << 8);
        
        for (j = 0; j < nbrofdma; j++) {
                /* for (i = 0; i < nbrofdma; i++) { */
                /*         regs[i]->time = 0; */
                /* } */
                /* cfgregs->timecode = (3 << 8); */
                
                regs[j]->ctrl = loadmem((int)&regs[j]->ctrl) | (1 << 4);
                while((loadmem((int)&regs[j]->ctrl) >> 4) & 1) {}
                
                for (i = 0; i < nbrofdma; i++) {
                        if (!(loadmem((int)&regs[i]->status) & 1)) {
                                fail(25);
                        }
                        if ((loadmem((int)&regs[i]->time) & 0xFF) != j+1) {
                                fail(26);
                        }
                }
                for (i = 0; i < nbrofdma; i++) {
                        regs[i]->status = loadmem((int)&regs[i]->status) | 1;
                }
                for(k = 0; k < udel; k++) {
                   asm volatile("nop");
                }
        }
                
        return 0;
}

int spwrouter_test(int ahbslv, int ahbslvaddr, int nbrofdma, int *dmaaddr)
{
   spwrouter_test_udel(ahbslv, ahbslvaddr, nbrofdma, dmaaddr, 64);
}
