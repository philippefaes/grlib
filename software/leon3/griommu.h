/*
 * GRLIB system test software for GRIOMMU core
 *
 * Copyright (c) 2010-2011 Aeroflex Gaisler AB
 *
 */

struct griommu_reg {
        volatile unsigned int cap[3];      /* 0x00 - 0x08 */
        volatile unsigned int dummy0;      /* 0x0C */
        volatile unsigned int ctrl;        /* 0x10 */    
        volatile unsigned int flush;       /* 0x14 */
        volatile unsigned int stat;        /* 0x18 */
        volatile unsigned int mask;        /* 0x1C */
        volatile unsigned int fail;        /* 0x20 */
        volatile unsigned int dummy1[7];   /* 0x24 - 0x3C */
        volatile unsigned int mstcfg[16];  /* 0x40 - 0x7C */
        volatile unsigned int grpctrl[16]; /* 0x80-0xBC */
        volatile unsigned int diaga;       /* 0xC0 */
        volatile unsigned int diagd[8];    /* 0xC4 - 0xE0 */
        volatile unsigned int diagt;       /* 0xE4 */
        volatile unsigned int derri;       /* 0xE8 */
        volatile unsigned int terri;       /* 0xEC */
        volatile unsigned int dummy2[4];   /* 0xF0 - 0xFC */
        volatile unsigned int asmpacc[15]; /* 0x100 - 0x138 */
};

/*
 * Register fields
 */

/* Capability register 0 */
#define GRIOMMU_CAP0_A       (1 << 31)
#define GRIOMMU_CAP0_AC      (1 << 30)
#define GRIOMMU_CAP0_CA      (1 << 29)
#define GRIOMMU_CAP0_CP      (1 << 28)
#define GRIOMMU_CAP0_NARB    20
#define GRIOMMU_CAP0_CS      19
#define GRIOMMU_CAP0_FT      17
#define GRIOMMU_CAP0_ST      (1 << 16)
#define GRIOMMU_CAP0_I       (1 << 15)
#define GRIOMMU_CAP0_IT      (1 << 14)
#define GRIOMMU_CAP0_IA      (1 << 13)
#define GRIOMMU_CAP0_IP      (1 << 12)
#define GRIOMMU_CAP0_MB      (1 << 8)
#define GRIOMMU_CAP0_GRPS    4
#define GRIOMMU_CAP0_MSTS    0

/* Capability register 1 */
#define GRIOMMU_CAP1_CADDR   20
#define GRIOMMU_CAP1_CMASK   16
#define GRIOMMU_CAP1_CTAGB   8
#define GRIOMMU_CAP1_CSIZE   5
#define GRIOMMU_CAP1_CLINES  0

/* Capability register 2 */
#define GRIOMMU_CAP2_TMASK   24
#define GRIOMMU_CAP2_MTYPE   18
#define GRIOMMU_CAP2_TTYPE   16
#define GRIOMMU_CAP2_TTAGB   8
#define GRIOMMU_CAP2_ISIZE   5
#define GRIOMMU_CAP2_TLBENT  0

/* Control register */
#define GRIOMMU_CTRL_PGSZ    18
#define GRIOMMU_CTRL_LB      (1 << 17)
#define GRIOMMU_CTRL_SP      (1 << 16)
#define GRIOMMU_CTRL_ITR     12
#define GRIOMMU_CTRL_DP      (1 << 11)
#define GRIOMMU_CTRL_SIV     (1 << 10)
#define GRIOMMU_CTRL_HPROT   8
#define GRIOMMU_CTRL_AU      (1 << 7)
#define GRIOMMU_CTRL_WP      (1 << 6)
#define GRIOMMU_CTRL_DM      (1 << 5)
#define GRIOMMU_CTRL_GS      (1 << 4)
#define GRIOMMU_CTRL_CE      (1 << 3)
#define GRIOMMU_CTRL_PM      (1 << 1)
#define GRIOMMU_CTRL_EN      (1 << 0)

/* Flush register */
#define GRIOMMU_FLUSH_FGRP    4
#define GRIOMMU_FLUSH_GF      (1 << 1)
#define GRIOMMU_FLUSH_F       (1 << 0)

/* Status register */
#define GRIOMMU_STAT_PE      (1 << 5)
#define GRIOMMU_STAT_DE      (1 << 4)
#define GRIOMMU_STAT_FC      (1 << 3)
#define GRIOMMU_STAT_FL      (1 << 2)
#define GRIOMMU_STAT_AD      (1 << 1)
#define GRIOMMU_STAT_TE      (1 << 0)

/* Mask register */
#define GRIOMMU_MASK_PEI     (1 << 5)
#define GRIOMMU_MASK_FCI     (1 << 3)
#define GRIOMMU_MASK_FLI     (1 << 2)
#define GRIOMMU_MASK_ADI     (1 << 1)
#define GRIOMMU_MASK_TEI     (1 << 0)

/* Failing access register */
#define GRIOMMU_FAIL_FADDR   5
#define GRIOMMU_FAIL_FW      (1 << 4)
#define GRIOMMU_FAIL_FMASTER 0

/* Group control register(s) */
#define GRIOMMU_GRPCTRL_BASE  2
#define GRIOMMU_GRPCTRL_P     (1 << 1)
#define GRIOMMU_GRPCTRL_AG    (1 << 0)

/* Diagnostic cache access register */
#define GRIOMMU_DIAGA_DA      (1 << 31)
#define GRIOMMU_DIAGA_RW      (1 << 30)
#define GRIOMMU_DIAGA_DP      (1 << 21)
#define GRIOMMU_DIAGA_TP      (1 << 20)


/* ASMP Register Block access control register */
#define GRIOMMU_ASMPCC_FC     (1 << 18)
#define GRIOMMU_ASMPCC_SC     (1 << 17)
#define GRIOMMU_ASMPCC_MC     (1 << 16)
#define GRIOMMU_ASMPCC_GRP    0


int griommu_flush(unsigned int addr);
int griommu_flush_start(unsigned int addr);
int griommu_flush_wait(unsigned int addr);
