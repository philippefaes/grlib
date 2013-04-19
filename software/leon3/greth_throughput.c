#include "testmod.h"
#include "../greth/greth_api.h"

#define SRC_MAC0  0xDE
#define SRC_MAC1  0xAD
#define SRC_MAC2  0xBE
#define SRC_MAC3  0xEF
#define SRC_MAC4  0x00
#define SRC_MAC5  0x20 

static int snoopen;

static inline int load(int addr)
{
    int tmp;        
    asm volatile(" lda [%1]1, %0 "
        : "=r"(tmp)
        : "r"(addr)
        );
    return tmp;
}

static inline char loadb(int addr)
{
  char tmp;        
  asm volatile (" lduba [%1]1, %0 "
      : "=r"(tmp)
      : "r"(addr)
  );
  return tmp;
}

struct greth_info greth;

int greth_throughput_test(int apbaddr)
{
        int tmp, i;
        int *len;
        unsigned char tmp2;
        unsigned char *txbuf;
        unsigned char *rxbuf;
        
        unsigned char wrarea[100];
        unsigned char *buf;
        
        len = malloc(sizeof(int));
        txbuf = malloc(1514);
        rxbuf = malloc(1514);
        
        /* initialize */
        report_device(0x0101D000);
        greth.regs = (greth_regs *) apbaddr;
        greth.esa[0] = SRC_MAC0;
        greth.esa[1] = SRC_MAC1;
        greth.esa[2] = SRC_MAC2;
        greth.esa[3] = SRC_MAC3;
        greth.esa[4] = SRC_MAC4;
        greth.esa[5] = SRC_MAC5;
        greth_init(&greth);
        
        /* Put phy in loopback*/
        tmp = read_mii(greth.phyaddr, 0, greth.regs);
        
        if (tmp < 0) {
                /* Error in MDIO interface access */ 
                fail(0);
        }

        write_mii(greth.phyaddr, 0, tmp | (1 << 14), greth.regs);
        
        /* Dest. addr */
        txbuf[0] = SRC_MAC0;
        txbuf[1] = SRC_MAC1;
        txbuf[2] = SRC_MAC2;
        txbuf[3] = SRC_MAC3;
        txbuf[4] = SRC_MAC4;
        txbuf[5] = SRC_MAC5;
        
        /* Source addr */
        txbuf[6]  = SRC_MAC0;
        txbuf[7]  = SRC_MAC1;
        txbuf[8]  = SRC_MAC2;
        txbuf[9]  = SRC_MAC3;
        txbuf[10] = SRC_MAC4;
        txbuf[11] = SRC_MAC5;
        
        /* Length 1500 (total length 1514 incl. address, type) */
        txbuf[12] = 0x05;
        txbuf[13] = 0xDC;
        
        for (i = 0; i < 128; i++) {
                while(!greth_rx(rxbuf, &greth));
                while(!greth_tx(1514, txbuf, &greth));
        }
        
        return 0;
        
}

