/* Base functionality test for GR1553B IP core */

#include "testmod.h"

static inline unsigned long rf(unsigned long addr)
{
  int tmp;
  asm volatile(" lda [%1] 1, %0 "
	       : "=r"(tmp)
	       : "r"(addr)
	       );
  return tmp;
}

static inline void wf(unsigned long addr, unsigned long data)
{
  asm volatile(" st %0, [%1]"
	       :
	       : "r"(data), "r"(addr));
}

/* Register struct */

struct gr1553b_regs {
  volatile unsigned long irq;
  volatile unsigned long irqen;
  volatile unsigned long res1[2];
  volatile unsigned long hwconfig;
  volatile unsigned long res2[11];
  volatile unsigned long bcstat;
  volatile unsigned long bcact;
  volatile unsigned long bcnextptr;
  volatile unsigned long bcanextptr;
  volatile unsigned long bctimer;
  volatile unsigned long bcwakeup;
  volatile unsigned long bcirqring;
  volatile unsigned long bcbusswap;
  volatile unsigned long res3[2];
  volatile unsigned long bcslotptr;
  volatile unsigned long bcaslotptr;
  volatile unsigned long res4[4];
  volatile unsigned long rtstat;
  volatile unsigned long rtcfg;
  volatile unsigned long rtbusstat;
  volatile unsigned long rtstwords;
  volatile unsigned long rtsync;
  volatile unsigned long rttblbase;
  volatile unsigned long rtmodectrl;
  volatile unsigned long res5[2];
  volatile unsigned long rttimectrl;
  volatile unsigned long res6;
  volatile unsigned long rtlogsize;
  volatile unsigned long rtlogpos;
  volatile unsigned long rtlogirqpos;
  volatile unsigned long res7[2];
  volatile unsigned long bmstat;
  volatile unsigned long bmctrl;
  volatile unsigned long bmaddrfilt;
  volatile unsigned long bmsafilt;
  volatile unsigned long bmmcfilt;
  volatile unsigned long bmlogstart;
  volatile unsigned long bmlogend;
  volatile unsigned long bmlogpos;
  volatile unsigned long bmtimectrl;
  volatile unsigned long res8[7];
};

/* Macros to assemble descriptors */
#define BCDESC0(wtrig,excl,irqe,irqn,suse,susn,retmd,nret,stbus,gap,stime) (((wtrig)<<30)|((excl)<<29)|((irqe)<<28)|((irqn)<<27)|((suse)<<26)|((susn)<<25)|((retmd)<<23)|((nret)<<20)|((stbus)<<19)|((gap)<<18)|(stime))
#define BCDESC1(dummy,bussel,rtto,rtad2,rtsa2,rtad1,tr,rtsa1,wcmc) (((dummy)<<31)|((bussel)<<30)|((rtto)<<26)|((rtad2)<<21)|((rtsa2)<<16)|((rtad1)<<11)|((tr)<<10)|((rtsa1)<<5)|(wcmc))
#define BCRES(rt2st,rtst,retcnt,tfrst) (((rt2st)<<16)|((rtst)<<8)|((retcnt)<<4)|(tfrst))
#define BMLOG1(bus,wst,wtp,wd) (((bus)<<19)|((wst)<<17)|((wtp)<<16)|(wd))
#define BMLOG1_CMD(bus,rta,tr,sa,wcmc) BMLOG1(bus,0,1,(((rta)<<11)|((tr)<<10)|((sa)<<5)|(wcmc)))

/* Basic BC/BM tests, don't require anything else connected to the
 * 1553 bus but the transceivers must be looping back correctly.
 *
 * BC tests sending a command list
 * BM is enabled during test, if transceivers connected then BC:s words should 
 * be logged.
 */
void gr1553b_test_bcbm(unsigned long regaddr, unsigned long memaddr)
{
  struct gr1553b_regs *r = (struct gr1553b_regs *)regaddr;
  unsigned long l;
  unsigned long const *p;
  int i,j,t;
  int bmstat;

  static const unsigned long bcdescs[] = { 
    /* bcast sync mode code, busA, WTRIG=1 */
    BCDESC0(1,0,0,0,0,0,0,0,0,0,0), 
    BCDESC1(0,0,0,0,0,31,1,31,1),
    0x00000000, 0xFFFFFFFF, 
    /* bcast receive 1word, busB */
    BCDESC0(0,0,0,0,0,0,0,0,0,0,0), 
    BCDESC1(0,1,0,0,0,31,0, 3,1),  
    0x00000000, 0xFFFFFFFF,
    /* receive 1 word, busA, retry on bus B, suspend after */
    BCDESC0(0,0,0,0,1,1,1,0,0,0,0), BCDESC1(0,0,0,0,0, 5,0, 4,1), 
    0x00000002, 0xFFFFFFFF
  };
  
  static const unsigned long expres[] = { 
    BCRES(0,0,0,0), BCRES(0,0,0,0), BCRES(0,0,1,1) 
  };
  
  static const unsigned long explog1[] = {
    BMLOG1_CMD(0,31,1,31,1),
    BMLOG1_CMD(1,31,0, 3,1),
    BMLOG1(1,0,0,0x54DA),
    BMLOG1_CMD(0,5,0,4,1),
    BMLOG1(0,0,0,0x8C2F),
    BMLOG1_CMD(1,5,0,4,1),
    BMLOG1(1,0,0,0x8C2F)
  };

  report_device(0x0104D000);
  
  /* Align memaddr to 16-byte */
  if ((memaddr & 15) != 0) memaddr += (16-(memaddr&15));

  /* Enable the BM, if available */
  bmstat = r->bmstat;
  if (bmstat & 0x80000000) {
    r->bmlogstart = memaddr;
    r->bmlogend = memaddr+255;
    r->bmlogpos = memaddr;
    r->bmctrl = 0x0000000F;
  }
  
  /* -------- BC tests --------- */

  if (r->bcstat & 0x80000000) {

    /* report_subtest(1); */

    /* Setup transfer list */
    l = memaddr+256;
    p = bcdescs;
    for (i=0; i<3; i++) {
      wf(l,*p);
      l += 4; p++;
      wf(l,*p);
      l += 4; p++;
      wf(l,*p+memaddr+512);
      l += 4; p++; 
      wf(l,*p);
      l += 4; p++;
    }
    
    /* Setup data buffers */
    wf(memaddr+512, 0x54DA8C2F);
    
    /* Start transfer list */
    r->bcnextptr = memaddr+256;
    r->bcact = 0x15520001;
    for (i=0;i<6;i++) {
       asm __volatile__ (" nop; nop; nop; nop; ");
    }

    /* Check that it's waiting for trigger */
    l = r->bcstat;
    if ((l & 7) != 4) fail(100 + (l&7));
    
    /* Push trigger */
    r->bcact = 0x15520008;
    asm __volatile__ (" nop; nop; nop; nop; ");    

    /* Wait for the schedule to finish */
    /* TODO: Use interrupt instead */
    while (1) {
      l = r->bcstat & 7;
      if (l == 3) break;
      if (l != 1 && l != 2) fail(2);
      for (i=0; i<8; i++) {
	asm __volatile__ (" nop; nop; nop; nop; ");
      }
    }
        
    /* Check results */
    for (i=0; i<3; i++) {
      l = rf(memaddr+256+16*i+12);
      if ((l & 0x80000000) != 0) fail(10*i+19);
      if (l != expres[i]) fail(10*i+10+(l&7));  
    }

    /* Check BM log, if BM available */
    if (bmstat & 0x80000000) {
      for (i=0; i<7; i++) {
	l = rf(memaddr+4+8*i);
	if (l != explog1[i])
	  fail(40+i);
      }
    }    
  }
}
