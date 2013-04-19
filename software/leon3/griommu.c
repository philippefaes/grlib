/*
 * GRLIB system test software for GRIOMMU core
 *
 * Copyright (c) 2010 Aeroflex Gaisler
 *
 * Function        Description
 * --------        -----------
 * _flush          Performs flush operation and waits for completion
 * _flush_start    Starts flush operation and returns
 * _flush_wait     Returns when flush operation has completed
 * _derrinj        Injects error at specified line in data RAM
 * _terrinj        Injects error at specified line in tag RAM
 * _test           System test, see function description below
 *
 */

#include "testmod.h"
#include "griommu.h"

/*
 * griommu_flush()
 *
 * Performs flush operation (blocking)
 *
 * Return values:
 * See description of _flush_start() and _flush_wait().
 */
int griommu_flush(unsigned int addr)
{
        int retval;
        retval = griommu_flush_start(addr);
        return (retval ? retval : griommu_flush_wait(addr));
}

/*
 * griommu_flush_start()
 *
 * Initiates flush operations
 *
 * Return values:
 * 0 - success
 * 1 - Flush operation was in progress
 * 2 - Previous flush not cleared in Status registers
 * 3 - Core is in diagnostic mode
 *
 */
int griommu_flush_start(unsigned int addr)
{
        struct griommu_reg *r = (struct griommu_reg *) addr;
        
        if (r->flush & (GRIOMMU_FLUSH_F | GRIOMMU_FLUSH_GF))
                return 1;

        if (r->stat & (GRIOMMU_STAT_FL | GRIOMMU_STAT_FC))
                return 2;

        if (r->ctrl & GRIOMMU_CTRL_DM)
                return 3;

        r->flush = GRIOMMU_FLUSH_F;

        return 0;
}

/*
 * griommu_flush_wait()
 *
 * Returns when flush operation has completed
 *
 * Return values:
 * 0 - success
 * 4 - FL bit was not set in status register
 *
 */
int griommu_flush_wait(unsigned int addr)
{
        unsigned int tmp;
        struct griommu_reg *r = (struct griommu_reg *) addr;
        
        do {
                tmp = r->stat;
                if (!(tmp & GRIOMMU_STAT_FL))
                        return 4;
        } while (!(tmp & GRIOMMU_STAT_FC));

        r->stat = GRIOMMU_STAT_FC | GRIOMMU_STAT_FL;
        
        return 0;
}



/* 
 * griommu_derrinj 
 *
 * Injects error at specified line in data RAM
 *
 */
void griommu_derrinj(unsigned int addr, unsigned int line)
{
        unsigned int tmp;
        struct griommu_reg *r = (struct griommu_reg *) addr;

        r->ctrl |= GRIOMMU_CTRL_DM;
        r->derri = -1;
        r->diaga = GRIOMMU_DIAGA_DA | line;
        do { tmp = r->diaga; } while(tmp & GRIOMMU_DIAGA_DA);
        r->derri = 0;
        r->ctrl &= ~GRIOMMU_CTRL_DM;
}


/* 
 * griommu_terrinj 
 *
 * Injects error at specified line in tag RAM
 *
 */
void griommu_terrinj(unsigned int addr, unsigned int line)
{
        unsigned int tmp;
        struct griommu_reg *r = (struct griommu_reg *) addr;

        r->ctrl |= GRIOMMU_CTRL_DM;
        r->terri = -1;
        r->diaga = GRIOMMU_DIAGA_DA | line;
        do { tmp = r->diaga; } while(tmp & GRIOMMU_DIAGA_DA);
        r->terri = 0;
        r->ctrl &= ~GRIOMMU_CTRL_DM;
}


/*
 * griommu_passtrough()
 *
 * Places all masters in group 0 and sets group 0 to passthrough
 *
 */
void griommu_passthrough(unsigned int addr)
{
        unsigned char i, ngrp, nmst;
        struct griommu_reg *r = (struct griommu_reg *) addr;
        
        nmst = r->cap[0] >> GRIOMMU_CAP0_MSTS;
        ngrp = ((nmst >> GRIOMMU_CAP0_GRPS) & 0xf) + 1;
        nmst = (nmst & 0xf) + 1;

        if (ngrp > 1) {
                for (i = 0; i < nmst; i++)
                        r->mstcfg[i] = 0;
        }
        
        r->grpctrl[0] = GRIOMMU_GRPCTRL_P | GRIOMMU_GRPCTRL_AG;

        r->ctrl = GRIOMMU_CTRL_EN;
}

/*
 * griommu_deny_all()
 *
 * Places all masters in disabled group 0
 *
 */
void griommu_deny_all(unsigned int addr)
{
        unsigned char i, ngrp, nmst;
        struct griommu_reg *r = (struct griommu_reg *) addr;
        
        nmst = r->cap[0] >> GRIOMMU_CAP0_MSTS;
        ngrp = ((nmst >> GRIOMMU_CAP0_GRPS) & 0xf) + 1;
        nmst = (nmst & 0xf) + 1;

        if (ngrp > 1) {
                for (i = 0; i < nmst; i++)
                        r->mstcfg[i] = 0;
        }
        
        r->grpctrl[0] = 0; 

        r->ctrl = GRIOMMU_CTRL_EN;
}



/*
 * griommu_reg_test()
 *
 * Called from griommu_test(). Performs read and
 * write operations to the core's register interface.
 *
 */
static void griommu_reg_test(unsigned int addr)
{
        unsigned char ngrp, nmst;
        unsigned int i, cap[3];
        struct griommu_reg *r = (struct griommu_reg *) addr;

        cap[0] = r->cap[0];
        cap[1] = r->cap[1];
        cap[2] = r->cap[2];
        
        /* Testing control register */
        r->ctrl = 0;
        if ((r->ctrl & ~GRIOMMU_CTRL_SP) && (cap[0] & GRIOMMU_CAP0_A)) 
                fail(1);
        if (!(r->ctrl & ~GRIOMMU_CTRL_SP) && !(cap[0] & GRIOMMU_CAP0_A) && 
            (cap[0] & GRIOMMU_CAP0_I)) fail(2);
        r->ctrl = GRIOMMU_CTRL_CE;
        if (((cap[0] & GRIOMMU_CAP0_AC) && !(r->ctrl & GRIOMMU_CTRL_CE)) ||
            (!(cap[0] & GRIOMMU_CAP0_AC) && (r->ctrl & GRIOMMU_CTRL_CE)))
                fail(3);
        r->ctrl = GRIOMMU_CTRL_GS;
        if (((cap[0] & GRIOMMU_CAP0_CA) && !(r->ctrl & GRIOMMU_CTRL_GS)) ||
            (!(cap[0] & GRIOMMU_CAP0_CA) && (r->ctrl & GRIOMMU_CTRL_GS)))
                fail(4);
        r->ctrl = GRIOMMU_CTRL_DM;
        if (((cap[0] & GRIOMMU_CAP0_AC) && !(r->ctrl & GRIOMMU_CTRL_DM)) ||
            (!(cap[0] & GRIOMMU_CAP0_AC) && (r->ctrl & GRIOMMU_CTRL_DM)))
                fail(5);
        r->ctrl = GRIOMMU_CTRL_WP;
        if (!(r->ctrl & GRIOMMU_CTRL_WP))
                fail(6);
        r->ctrl = GRIOMMU_CTRL_AU;
        if (!(r->ctrl & GRIOMMU_CTRL_AU))
                fail(7);
        r->ctrl = 0x3 << GRIOMMU_CTRL_HPROT;
        if (((cap[0] & (GRIOMMU_CAP0_A | GRIOMMU_CAP0_I)) && 
             (((r->ctrl >> GRIOMMU_CTRL_HPROT) & 0x3) != 0x3)) ||
            (!(cap[0] & (GRIOMMU_CAP0_A | GRIOMMU_CAP0_I)) && 
               ((r->ctrl >> GRIOMMU_CTRL_HPROT) & 0x3)))
                fail(8);
        r->ctrl = GRIOMMU_CTRL_SIV;
        if (((cap[0] & GRIOMMU_CAP0_IT) && !(r->ctrl & GRIOMMU_CTRL_SIV)) ||
            (!(cap[0] & GRIOMMU_CAP0_IT) && (r->ctrl & GRIOMMU_CTRL_SIV)))
                fail(9);
        /* DP bit skipped */
        r->ctrl = 0xf << GRIOMMU_CTRL_ITR;
        if (((cap[0] & GRIOMMU_CAP0_IT) && (((r->ctrl >> GRIOMMU_CTRL_ITR) & 0xf) != 0xf)) ||
            (!(cap[0] & GRIOMMU_CAP0_IT) && (((r->ctrl >> GRIOMMU_CTRL_ITR) & 0xf) != 0)))
                fail(10);
        r->ctrl = GRIOMMU_CTRL_LB;
        if (((cap[0] & GRIOMMU_CAP0_MB) && !(r->ctrl & GRIOMMU_CTRL_LB)) ||
            (!(cap[0] & GRIOMMU_CAP0_MB) && (r->ctrl & GRIOMMU_CTRL_LB)))
                fail(11);
        r->ctrl = 0x7 << GRIOMMU_CTRL_PGSZ;
        if (((cap[0] & GRIOMMU_CAP0_CS) && (((r->ctrl >> GRIOMMU_CTRL_PGSZ) & 0x7) != 0x7)) ||
            (!(cap[0] & GRIOMMU_CAP0_CS) && (((r->ctrl >> GRIOMMU_CTRL_PGSZ) & 0x7) != 0)))
                fail(12);

        r->ctrl = 0;

        /* Status register is not tested */

        /* Test mask register */
        r->mask = GRIOMMU_MASK_TEI;
        if (!(r->mask &  GRIOMMU_MASK_TEI))
                fail(13);
        r->mask = GRIOMMU_MASK_ADI;
        if (!(r->mask &  GRIOMMU_MASK_ADI))
                fail(14);
        r->mask = GRIOMMU_MASK_FLI;
        if (((cap[0] & GRIOMMU_CAP0_AC) && !(r->mask & GRIOMMU_MASK_FLI)) ||
            (!(cap[0] & GRIOMMU_CAP0_AC) && (r->mask & GRIOMMU_MASK_FLI)))
                fail(15);
        r->mask = GRIOMMU_MASK_FCI;
        if (((cap[0] & GRIOMMU_CAP0_AC) && !(r->mask & GRIOMMU_MASK_FCI)) ||
            (!(cap[0] & GRIOMMU_CAP0_AC) && (r->mask & GRIOMMU_MASK_FCI)))
                fail(16);
        r->mask = GRIOMMU_MASK_PEI;
        if ((((cap[0] >> GRIOMMU_CAP0_FT) & 0x3) && !(r->mask & GRIOMMU_MASK_PEI)) ||
            (!((cap[0] >> GRIOMMU_CAP0_FT) & 0x3) && (r->mask & GRIOMMU_MASK_PEI)))
                fail(17);
        
        nmst = ((cap[0] >> GRIOMMU_CAP0_MSTS) & 0xf) + 1;
        ngrp = ((cap[0] >> GRIOMMU_CAP0_GRPS) & 0xf) + 1;
        
        /* Master group assignment registers */
        if (ngrp > 1) {
                for (i = 0; i < nmst; i++) {
                        r->mstcfg[i] = ngrp-1;
                        if ((r->mstcfg[i] & 0xfff) != ngrp-1)
                                fail(18+i);
                        r->mstcfg[i] = 0;
                }
        }

        /* Group base address registers */
        for (i = 0; i < ngrp; i++) {
                r->grpctrl[i] = GRIOMMU_GRPCTRL_AG;
                if (!(r->grpctrl[i] & GRIOMMU_GRPCTRL_AG))
                        fail(33+i*5);
                if  ((r->grpctrl[i] & ~GRIOMMU_GRPCTRL_AG))
                        fail(33+i*5+1);
                if (cap[0] & GRIOMMU_CAP0_I) {
                        r->grpctrl[i] = GRIOMMU_GRPCTRL_P;
                        if (!(r->grpctrl[i] & GRIOMMU_GRPCTRL_P))
                                fail(33+i*5+2);
                        r->grpctrl[i] = 0xffff8000;
                        if (r->grpctrl[i] != 0xffff8000)
                                fail(33+i*5+3); 
                } else if (cap[0] & GRIOMMU_CAP0_A) {
                        r->grpctrl[i] = GRIOMMU_GRPCTRL_P;
                        if (!(r->grpctrl[i] & GRIOMMU_GRPCTRL_P))
                                fail(33+i*5+2);
                        r->grpctrl[i] = 0xffff8000;
                        if (r->grpctrl[i] != 0xfffe0000)
                                fail(33+i*5+3);
                } else {
                        r->grpctrl[i] = GRIOMMU_GRPCTRL_P;
                        if ((r->grpctrl[i] & GRIOMMU_GRPCTRL_P))
                                fail(33+i*5+2);
                        r->grpctrl[i] = 0xffff8000;
                        if (r->grpctrl[i] != 0)
                                fail(33+i*5+3);
                }
                r->grpctrl[i] = 0;
                if (r->grpctrl[i])
                        fail(33+i*5+4);
        }

        /*
         * Diagnostic cache access registers not tested here as they may
         * contain bad values. The registers are used during the diagnostic
         * cache access test later.
         *
         */
        
        /* Data RAM error injection register */
        r->derri = -1;
        if ((((cap[0] >> GRIOMMU_CAP0_FT) & 0x3) && !(r->derri)) ||
            (!((cap[0] >> GRIOMMU_CAP0_FT) & 0x3) && (r->derri)))
                fail(113);
        r->derri = 0;
        
        /* Tag RAM error injection register */
        r->terri = -1;
        if ((((cap[0] >> GRIOMMU_CAP0_FT) & 0x3) && !(r->terri)) ||
            (!((cap[0] >> GRIOMMU_CAP0_FT) & 0x3)&& (r->terri)))
                fail(114);
        r->terri = 0;
        
        /* ASMP Access control register(s) */
        for (i = 0; i < ((cap[0] >> GRIOMMU_CAP0_NARB) & 0xf); i++) {
                r->asmpacc[i] = GRIOMMU_ASMPCC_FC;
                if (!(r->asmpacc[i] & GRIOMMU_ASMPCC_FC))
                        fail(115+i*4);
                r->asmpacc[i] = GRIOMMU_ASMPCC_SC;
                if (!(r->asmpacc[i] & GRIOMMU_ASMPCC_SC))
                        fail(115+i*4+1);
                r->asmpacc[i] = GRIOMMU_ASMPCC_MC;
                if (!(r->asmpacc[i] & GRIOMMU_ASMPCC_MC))
                        fail(115+i*4+2);
                r->asmpacc[i] = 0;
                if (r->asmpacc[i])
                        fail(115+i*4+3);
        }
}

/*
 * griommu_diag_test()
 *
 * Called from griommu_test(). Performs read and
 * write operations to a few lines in the cache.
 *
 */
static void griommu_diag_test(unsigned int addr)
{
        unsigned char ndregs, ntagb, i, j;
        unsigned int tmp, nlines;
        struct griommu_reg *r = (struct griommu_reg *) addr;

        tmp = r->cap[1];
        ndregs = 1 << (((tmp >> GRIOMMU_CAP1_CSIZE) & 0x7));
        ntagb = (tmp >> GRIOMMU_CAP1_CTAGB) & 0xff;
        nlines = (1 << ((tmp >> GRIOMMU_CAP1_CLINES) & 0x1f));
        nlines = nlines > 4 ? 4 : nlines;

        /* Enable diagnostic mode */
        r->ctrl = GRIOMMU_CTRL_DM;

        if (!(r->stat & GRIOMMU_STAT_DE))
                fail(1);

        /* Cache has been flushed so it is safe to access the diaga register */
        
        /* Write cache */
        for (i = 0; i < nlines; i++) {
                /* Data RAM */
                tmp = i & 1 ? 0 : -1;
                for (j = 0; j < ndregs; j++) {
                        r->diagd[j] = tmp;
                        tmp = ~tmp;
                }
                /* Tag RAM */
                r->diagt = 1 << (i % ntagb); 

                /* Commit */
                r->diaga = GRIOMMU_DIAGA_DA | i;
                do { tmp = r->diaga; } while(tmp & GRIOMMU_DIAGA_DA);
                if (tmp & (GRIOMMU_DIAGA_DP | GRIOMMU_DIAGA_TP)) fail(3+i);
        }

        /* Read cache */
        for (i = 0; i < nlines; i++) {
                /* Read */
                r->diaga = GRIOMMU_DIAGA_DA | GRIOMMU_DIAGA_RW | i;
                do { tmp = r->diaga; } while(tmp & GRIOMMU_DIAGA_DA);
                if (tmp & (GRIOMMU_DIAGA_DP | GRIOMMU_DIAGA_TP)) fail(7+3*i);

                /* Data RAM */
                tmp = i & 1 ? 0 : -1;
                for (j = 0; j < ndregs; j++) {
                        if (r->diagd[j] != tmp)
                                fail(7+3*i+1);
                        tmp = ~tmp;
                }
                /* Tag RAM */
                if (r->diagt != (1 << (i % ntagb)))
                        fail(7+i*3+2);
        }

        /* Make sure that we did not leave any valid bits set */
        for (i = 0; i < nlines; i++) {
                /* Tag RAM */
                r->diagt = 0;
                /* Commit */
                r->diaga = GRIOMMU_DIAGA_DA | i;
                do { tmp = r->diaga; } while(tmp & GRIOMMU_DIAGA_DA);
                if (tmp & (GRIOMMU_DIAGA_DP | GRIOMMU_DIAGA_TP)) fail(19+i);
        }

        /* Leave diagnostic mode and disable core */
        r->ctrl = 0;
}

/*
 * griommu_ft_test()
 *
 * Called from griommu_test(). Tests parity checks by
 * performing diagnostic accesses and injecting errors.
 *
 */
static void griommu_ft_test(unsigned int addr)
{
        unsigned char ndbytes, ntbytes, i, j;
        unsigned int tmp, nlines;
        struct griommu_reg *r = (struct griommu_reg *) addr;

        if (r->cap[0] & GRIOMMU_CAP0_A) {
                tmp = r->cap[1];
                ndbytes = 1 << (((tmp >> GRIOMMU_CAP1_CSIZE) & 0x7) + 2);
                ntbytes = (((tmp >> GRIOMMU_CAP1_CTAGB) & 0xff)+7)/8;
                nlines = 1 << ((tmp >> GRIOMMU_CAP1_CLINES) & 0x1f);
                nlines = nlines > 4 ? 4 : nlines;
        } else {
                tmp = r->cap[2];
                ndbytes = 1 << (((tmp >> GRIOMMU_CAP2_ISIZE) & 0x7) + 2);
                ntbytes = (((tmp >> GRIOMMU_CAP2_TTAGB) & 0xff)+7)/8;
                nlines = 1 << ((tmp >> GRIOMMU_CAP2_TLBENT) & 0x1f);
                nlines = nlines > 4 ? 4 : nlines;
        }

        /* Enable diagnostic mode */
        r->ctrl = GRIOMMU_CTRL_DM;

        for (i = 0; i < ndbytes+ntbytes; i++) {
                /* Read */
                r->diaga = GRIOMMU_DIAGA_DA | GRIOMMU_DIAGA_RW;
                do { tmp = r->diaga; } while(tmp & GRIOMMU_DIAGA_DA);
                if (tmp & (GRIOMMU_DIAGA_DP | GRIOMMU_DIAGA_TP)) fail(i*5);  

                /* Inject error */
                if (i < ndbytes) {
                        r->derri = 1 << i;
                } else {
                        r->terri = 1 << (i-ndbytes); 
                }
                
                /* Write */
                r->diaga = GRIOMMU_DIAGA_DA;
                do { tmp = r->diaga; } while(tmp & GRIOMMU_DIAGA_DA);
                
                /* Read */
                r->diaga = GRIOMMU_DIAGA_DA | GRIOMMU_DIAGA_RW;
                do { tmp = r->diaga; } while(tmp & GRIOMMU_DIAGA_DA);
                if ((i < ndbytes) && !(tmp & GRIOMMU_DIAGA_DP))
                        fail(i*5+1);
                if ((i < ndbytes) && (tmp & GRIOMMU_DIAGA_TP))
                        fail(i*5+2);
                if ((i >= ndbytes) && (tmp & GRIOMMU_DIAGA_DP))
                        fail(i*5+3);
                if ((i >= ndbytes) && !(tmp & GRIOMMU_DIAGA_TP))
                        fail(i*5+4);

                /* Clear error injection */
                if (i < ndbytes) {
                        r->derri = 0;
                } else {
                        r->terri = 0;
                }
                
                /* Write */
                r->diaga = GRIOMMU_DIAGA_DA;
                do { tmp = r->diaga; } while(tmp & GRIOMMU_DIAGA_DA);
        }        

        /* Leave diagnostic mode and disable core */
        r->ctrl = 0;
}


/*
 * griommu_test()
 * 
 * GRLIB system test intended to be run in simulation. Tests:
 *
 * Basic tests on register interface
 * Cache flush operation
 * Diagnostic cache accesses
 * Fault-tolerance 
 *
 */
void griommu_test(unsigned int addr)
{
        int retval;
        struct griommu_reg *r = (struct griommu_reg *) addr;
        
        report_device(0x0104f000);

        /* Read out values from capbility registers */

        /* Basic tests on register interface */
        report_subtest(1);
        griommu_reg_test(addr);

        if (r->cap[0] & GRIOMMU_CAP0_AC) {
                /* Perform cache flush */
                report_subtest(2);
                retval = griommu_flush(addr);
                if (retval) fail(retval);

                /* Diagnostic cache accesses */
                report_subtest(3);
                griommu_diag_test(addr);
        }


        if ((r->cap[0] >> GRIOMMU_CAP0_FT) & 0x3) {
                /* Test fault tolerance */
                report_subtest(4);
                griommu_ft_test(addr);
        }
}
