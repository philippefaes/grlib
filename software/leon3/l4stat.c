/*
 * GRLIB system test software for L4STAT core
 *
 * Copyright (c) 2010 Aeroflex Gaisler
 *
 */

#include "testmod.h"

/* Register offsets */
#define L4STAT_VAL_REG  0x00
#define L4STAT_CTRL_REG 0x80

/* Counter control register fields */
#define L4STAT_CTRL_NCPU     28
#define L4STAT_CTRL_NCPU_MSK 0xf
#define L4STAT_CTRL_NCNT     23
#define L4STAT_CTRL_NCNT_MSK 0x1f
#define L4STAT_CTRL_MC       (1 << 22)
#define L4STAT_CTRL_IA       (1 << 21)
#define L4STAT_CTRL_DS       (1 << 20)
#define L4STAT_CTRL_EE       (1 << 19)
#define L4STAT_CTRL_R        (1 << 18)
#define L4STAT_CTRL_EL       (1 << 17)
#define L4STAT_CTRL_CD       (1 << 16)
#define L4STAT_CTRL_SU       14
#define L4STAT_CTRL_SU_MSK   0x3
#define L4STAT_CTRL_CL       (1 << 13)
#define L4STAT_CTRL_EN       (1 << 12)
#define L4STAT_CTRL_ID       4
#define L4STAT_CTRL_ID_MSK   0xff
#define L4STAT_CTRL_CPU      0
#define L4STAT_CTRL_CPU_MSK  0xf


void l4stat_test(unsigned int addr)
{
        unsigned char ncnt;
        volatile unsigned int *val, *ctrl;
        unsigned int i, tmp;

        val = (unsigned int*)(addr + L4STAT_VAL_REG);
        ctrl = (unsigned int*)(addr + L4STAT_CTRL_REG);

        report_device(0x01047000);

        *ctrl = 0; /* Initialize before reading # counters */
        ncnt = ((*ctrl >>  L4STAT_CTRL_NCNT) & L4STAT_CTRL_NCPU_MSK) + 1;
        
        /* Loop through all counters */
        for (i = 0; i < ncnt; i++) {
                report_subtest(i);

                ctrl[i] = 0;
                val[i] = 0;
                ctrl[i] = (L4STAT_CTRL_EL | L4STAT_CTRL_CD |
                           (L4STAT_CTRL_SU_MSK << L4STAT_CTRL_SU) |
                           (L4STAT_CTRL_ID_MSK << L4STAT_CTRL_ID) |
                           (L4STAT_CTRL_CPU_MSK << L4STAT_CTRL_CPU));
                tmp = ctrl[i];
                
                /* Check control register fields */
                if (((tmp & (L4STAT_CTRL_EL | L4STAT_CTRL_CD)) && !(tmp & L4STAT_CTRL_MC)) ||
                    (!(tmp & (L4STAT_CTRL_EL | L4STAT_CTRL_CD)) && (tmp & L4STAT_CTRL_MC)))
                        fail(0);
                if (((tmp >> L4STAT_CTRL_SU) & L4STAT_CTRL_SU_MSK) != L4STAT_CTRL_SU_MSK)
                        fail(1);
                if (tmp & L4STAT_CTRL_CL) fail(2);
                if (tmp & L4STAT_CTRL_EN) fail(3);
                if (((tmp & (L4STAT_CTRL_DS |  L4STAT_CTRL_EE)) && 
                     (((tmp >> L4STAT_CTRL_ID) & L4STAT_CTRL_ID_MSK) != 0x7f)) ||
                    (!(tmp & (L4STAT_CTRL_DS |  L4STAT_CTRL_EE)) && 
                     (((tmp >> L4STAT_CTRL_ID) & L4STAT_CTRL_ID_MSK) != 0x3f)))
                        fail(4);
                if (((tmp >> L4STAT_CTRL_CPU) & L4STAT_CTRL_CPU_MSK) != L4STAT_CTRL_CPU_MSK)
                        fail(5);

                /* Check value register */
                if (val[i]) fail(6);
                val[i] = 0xa5a5a5a5;
                if (val[i] != 0xa5a5a5a5) fail(7);
                val[i] = 0x5a5a5a5a;
                if (val[i] != 0x5a5a5a5a) fail(8);
                val[i] = 0;
                
                /* Count total instructions on CPU 0*/
                ctrl[i] = L4STAT_CTRL_EN | (0x11 << L4STAT_CTRL_ID);
                if (!(ctrl[i] & L4STAT_CTRL_EN)) fail(9); 
                if (!val[i]) fail(10);
                
                /* Test clear on read */
                ctrl[i] |= L4STAT_CTRL_CL;
                if (!val[i] || !val[i]) fail(11);
                ctrl[i] &= ~L4STAT_CTRL_EN;
                if (val[i] && val[i]) fail(12);

                ctrl[i] = 0;
        }
}

