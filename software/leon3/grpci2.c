/*
  Systest for GRPCI2.
    Configure the cores:  Enable Master and Target, set latency timer to 0x40
                          BAR0 = 0x40000000 => AHB address of data[]
                          All AHB master => PCI address 0x80000000
                          PCI IO cycles => PCI address 0xC0000000
    Configure TB target:  Enable Target 
                          BAR0 = 0x80000000 - MEM BAR
                          BAR1 = 0xC0000001 - IO BAR
    Test:
      Setup data[]
      Write PCI address fot data[] to 0x80000100
      PCI MEM write/read test to 0x80000000 - 0x80000040
      PCI IO write/read test to 0xC0000000 - 0xC0000040
      Wait for TB master to replace data[] (wait for PCI address 0x80000104 reading 1)
      Check the incremental data in data[]
      done
*/
static inline int loadmem(int addr)
{
  int tmp;        
  asm volatile (" lda [%1]1, %0 "
    : "=r"(tmp)
    : "r"(addr)
  );
  return tmp;
}
int grpci2_test(unsigned int base_addr, unsigned int conf_addr, unsigned int apb_addr, int slot) {
  volatile unsigned int *base   = (unsigned int *) base_addr; 
  volatile unsigned int *baseio = (unsigned int *) (conf_addr); 
  volatile unsigned int *conf   = (unsigned int *) (conf_addr + 0x10000); 
  volatile unsigned int *apb    = (unsigned int *) apb_addr; 
  int i;

  unsigned int tmp, data_addr;
  unsigned int data[16];

  unsigned int tw(unsigned int data){
    return ((data & 0xff) << 24) | (((data >> 8) & 0xff) << 16) | (((data >> 16) & 0xff) << 8) | (((data >> 24) & 0xff)); 
  }

  report_device(0x0107C000);

  data_addr = (int)data;

  // PCI self configuration
  report_subtest(1);
  // Enable PCI master and mem access
  *(conf+1) = tw(0x00000146);
  *(conf+3) = tw(0x00004000);
  *(conf+0x60/4) = tw(0x00000001);

  // BAR0
  *(conf+4) = tw(0x40000000);
  if ((*(conf+4) & 0xf0ffffff) != tw(0x40000000)) fail(1);
  // BAR0 to AHB
  //*(conf+17) = tw(0x00000000);
  //if (*(conf+17) != tw(0x00000000)) fail(2);
  *(conf+17) = tw(0xffffffff);
  tmp = tw((*(conf+17) & 0xf0ffffff));
  *(conf+17) = tw(data_addr);
  if ((*(conf+17) & 0xf0ffffff) != tw((data_addr & tmp))) fail(2);

  // AHB master to PCI
  for (i=0; i<16; i++){
    *(apb+16+i) = 0x80000000;
  }
  
  // AHB => PCI IO
  *(apb+3) = 0xc0000000;
  
  // conf target
  report_subtest(2);
  *(conf+(0x800*(18+slot))/4+1) = tw(0x00000146);
  if (*(conf+(0x800*(18+slot))/4) != tw(0x2badaffe)) fail(3);
  *(conf+(0x800*(18+slot))/4+4) = tw(0x80000000);
  if (*(conf+(0x800*(18+slot))/4+4) != tw(0x80000000)) fail(4);
  *(conf+(0x800*(18+slot))/4+5) = tw(0xC0000000);
  if (*(conf+(0x800*(18+slot))/4+5) != tw(0xC0000001)) fail(5);

  // generate test data for TB master
  for (i=0;i<16;i++){
    data[i] = (((i+7)&0xf)<<28) |(((i+6)&0xf)<<24) |(((i+5)&0xf)<<20) |(((i+4)&0xf)<<16) 
             |(((i+3)&0xf)<<12) |(((i+2)&0xf)<<8)  |(((i+1)&0xf)<<4)  |(((i+0)&0xf));
  }
  *(base + 0x100/4) = tw(0x40000000 | (data_addr&(~tmp)));

  // test PCI mem-access
  report_subtest(3);
  for (i=0; i<16; i++){
    *(base+i) = ((i&0xf)<<28) |((i&0xf)<<24) |((i&0xf)<<20) |((i&0xf)<<16) 
               |((i&0xf)<<12) |((i&0xf)<<8)  |((i&0xf)<<4)  |((i&0xf));
  }

  for (i=0; i<16; i++){
    if (*(base+i) != (((i&0xf)<<28) |((i&0xf)<<24) |((i&0xf)<<20) |((i&0xf)<<16) 
                    |((i&0xf)<<12) |((i&0xf)<<8)  |((i&0xf)<<4)  |((i&0xf)))) fail(1);
  }
  
  // test PCI io-access
  report_subtest(4);
  for (i=0; i<16; i++){
    *(baseio+i) = ((i&0xf)<<28) |((i&0xf)<<24) |((i&0xf)<<20) |((i&0xf)<<16) 
                 |((i&0xf)<<12) |((i&0xf)<<8)  |((i&0xf)<<4)  |((i&0xf));
  }

  for (i=0; i<16; i++){
    if (*(baseio+i) != (((i&0xf)<<28) |((i&0xf)<<24) |((i&0xf)<<20) |((i&0xf)<<16) 
                      |((i&0xf)<<12) |((i&0xf)<<8)  |((i&0xf)<<4)  |((i&0xf)))) fail(1);
  }
 
  // wait on testbench master
  do{
    i=50;while(i!=0)i--;
    tmp = *(base + 0x104/4);
  }while (tmp != 1);

  // check data
  report_subtest(5);
  for (i=0;i<16;i++){
    //if (data[i] != i)fail(1);
    if (loadmem(&data[i]) != i)fail(1);
  }


}
