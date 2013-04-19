struct timerreg {
    volatile unsigned int counter;		/* 0x0 */
    volatile unsigned int reload;		/* 0x4 */
    volatile unsigned int control;		/* 0x8 */
    volatile unsigned int dummy;		/* 0xC */
};

struct gptimer {
    volatile unsigned int scalercnt;		/* 0x00 */
    volatile unsigned int scalerload;		/* 0x04 */
    volatile unsigned int configreg;		/* 0x08 */
    volatile unsigned int dummy1;		/* 0x0C */
    struct timerreg timer[7];
};

#define IRQPEND 0x10
#define CHAIN_TEST 8
