#include "testmod.h"

struct memscrub_regs {
  volatile unsigned long ahbstat;
  volatile unsigned long ahbaddr;
  volatile unsigned long ahberrconf;
  volatile unsigned long res;
  volatile unsigned long scrubstat;
  volatile unsigned long scrubconf;
  volatile unsigned long scrublowaddr;
  volatile unsigned long scrubhighaddr;
  volatile unsigned long scrubpos;
  volatile unsigned long scruberrthres;
  volatile unsigned long scrubinit;  
};


static unsigned long dbuf[64];
static const unsigned long initdata[] = { 0x01234567, 0x89ABCDEF, 0x00112233, 0x44556677, 
					  0x8899AABB, 0xCCDDEEFF, 0x00011122, 0x23334445,
					  0x55666777, 0x888999AA, 0xABBBCCCD, 0xDDEEEFFF,
					  0x00001111, 0x22223333, 0x44445555, 0x66667777 };


void memscrub_irqhandler(int irq)
{
   /* Do nothing */
   return;
}


/* addr: Base address of memscrub registers
 * hirq: IRQ # of scrubber
 */

void memscrub_test(unsigned long addr, int hirq)
{
  int bmask,blen,i;
  struct memscrub_regs *r = (struct memscrub_regs *)addr;
  unsigned long s,e;  

  report_device(0x01057000);

  catch_interrupt(memscrub_irqhandler, hirq);

  /* Detect burst length */
  r->scrubhighaddr = 0;
  bmask = r->scrubhighaddr;
  blen = (bmask+1) >> 2;

  for (i=0; i<blen; i++)
    r->scrubinit = initdata[i];  

  /* Realign start/end of dbuf to block boundary */
  s = (unsigned long)dbuf;
  s = (s+bmask) & (~bmask);
  e = s + (blen<<2) + (blen<<3) - 1; /* Three full bursts */

  r->scrublowaddr = s;
  r->scrubhighaddr = e;

  /* Initialize dbuf */
  r->scrubconf = 0x00000009;

  /* Wait until init done */
  while ((r->scrubstat & 1) != 0) { __asm__ volatile ("nop\n\t" "nop\n\t" "nop\n\t"); }

  /* Verify buffer contents */
  for (; s<e; s += bmask+1) {
    for (i=0; i<blen; i++) 
      if (((unsigned long *)s)[i] != initdata[i]) fail(1);
  }

}
