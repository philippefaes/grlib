#define MCFG1 0x103809FF
// 000  rsvd
//  10  iobusw = 32 bit
//   0  io bus ready
//   0  bus error enable
//   0  rsvd
//0011  io waitstates during i/o access = 3
//   1  io enable
//0000000 rsvd
//   1  prom write enable
//   0  rsvd
//  01  prom width 16 bit
//1111  prom wr waitstates (15)
//1111  prom rd waitstates (15)

 
#define MCFG2 0xe6A0106F
//#define MCFG2 0xe6A06e60
//   1 sdram refresh
//   1 trp param (3 cycles)
// 100 trfc 3+4 cycles
//   1 tcas (3 cycles)
// 101 sdram bank size (128M)
//  01 sdram column size (512)
//  00 sdram command (nop)
//   0 64 bit sdram (0 => 32 bit)
// 000 rsvd
//   0 sdram enable
//   0 sram disable
//1000 ram bank size (2MB)
//   0 rsvd
//   0 ram bus rdy enable
//   1 read mod write enable (sub word)
//  10 ram width (32)
//  11 ram write waitstates => 3
//  11 ram read waitstates => 3


#define MCFG3 0x000ff000
//
//00000 rsvd
// 000 0000 1111 1111 sram refresh counter
//0000 0000 0000 rsvd


#define ASDCFG 0xfff00100
#define DSDCFG 0xe6A06e60
//DDR2 SDRAM Config:
//  28   24   20   16   12    8    4    0
//1110 0110 1010 0000 0110 1110 0110 0000
//1 sram refresh
//1 ocd operation
//10 extended mode
//0 rsvd
//1 sdram trcd (2+1=3)
//101 bank size 256MB
//000 sdram command
//0 pll reset
//0 initialize
//0 clock enable
//110 1110 0110 0000 period auto refresh


#define L2MCTRLIO 0x80000000
#define IRQCTRL   0x80000200
#define RAMSTART  0x40000000
#define RAMSIZE   0x00100000

