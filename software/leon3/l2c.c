/*
 * Test for L2-Cache
 *
 * Copyright (c) 2009 Aeroflex Gaisler AB
 *
 */

#include "testmod.h"

/* L2C registers */
struct l2c_regs {
   volatile unsigned int ctrl;
   volatile unsigned int status;
   volatile unsigned int flush_mem;
   volatile unsigned int flush_dir;
   volatile unsigned int acc_cnt;
   volatile unsigned int hit_cnt;
   volatile unsigned int cyc_cnt;
   volatile unsigned int bus_cnt;
   volatile unsigned int err_ctrl;
   volatile unsigned int err_addr;
   volatile unsigned int wtcb;
   volatile unsigned int wcb;
   unsigned int dummy[5*4];
   volatile unsigned int tmrr;
};


/*
 * l2c_enable(..)
 *
 * regaddr - L2C register base address
 * ften    - Enable FT
 *
 */
int l2c_enable(unsigned int regaddr, unsigned int ften)
{
  unsigned int ctrl;
  struct l2c_regs *l2c;
  
  report_device(0x0104B000);

  l2c = (struct l2c_regs*)regaddr;

  report_subtest(1);
  
  // Flush and enable L2-Cache  
  ctrl = l2c->ctrl;
  if ((ctrl >> 31) == 0) {
    l2c->flush_mem = 5;
    l2c->ctrl = ctrl | (1<<31) | (ften << 30);
  };
  
  return 0;
}

/*
 * l2c_enable_wayflush(..)
 *
 * regaddr - L2C register base address
 *
 */
int l2c_enable_wayflush(unsigned int regaddr, unsigned int ften, int nways)
{
  int i;
  unsigned int ctrl;
  struct l2c_regs *l2c;
  
  report_device(0x0104B000);

  l2c = (struct l2c_regs*)regaddr;

  report_subtest(1);
  
  // Flush and enable L2-Cache  
  ctrl = l2c->ctrl;
  if ((ctrl >> 31) == 0) {
    for (i = 0; i < nways; i++)
       l2c->flush_dir = (i << 4) | 5;
    l2c->ctrl = ctrl | (1<<31) | (ften << 30);
  };
  
  return 0;
}

/*
 * l2c_test(..)
 *
 * memaddr - Memory address
 * regaddr - L2C register base address
 *
 */
int l2c_test(unsigned int memaddr, unsigned int regaddr)
{
  l2c_enable(regaddr, 0);
}

