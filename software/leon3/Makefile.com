VPATH=$(GRLIB)/software/leon3
XCC=sparc-elf-gcc -I$(GRLIB)/software/leon3 $(BOPT)
XAS=sparc-elf-gcc -c -I. -I$(GRLIB)/software/leon3 $(BOPT)
XAR=sparc-elf-ar
XCFLAGS=-O2 -g -msoft-float
XLDFLAGS=-L./ lib3tests.a $(LDFLAGS)

# NOTE: When adding files to PROGS, also add them to Makefile.gpl

PROGS = report_device apbuart divtest multest regtest \
	cache gpio ramfill ramtest irqmp leon3_test gptimer \
	mulasm cacheasm spwtest mptest fpu grfpu_ops \
	base_test grfpu_test can_oc mmu mmu_asm pcitest greth atactrl \
	amba dsu3 greth_api grcan \
	spictrl i2cmst misc spimctrl svgactrl apbps2 \
	i2cslv i2c l2c  leon4_test base_test4 griommu l4stat \
	grpci2 $(EXTRA_PROGS)

OFILES = $(PROGS:%=%.o)

%.o: %.c
	$(XCC) $(XCFLAGS) -c  $<

%.o: %.S
	$(XCC) $(XCFLAGS) -c  $<

fpu.o: fpu.c
	$(XCC) -ffast-math -O3 -c  $<

multest.o: multest.c
	$(XCC) -O2 -c -mcpu=v8  $<

divtest.o: divtest.c
	$(XCC) -O2 -c -mcpu=v8  $<

greth_api.o : $(GRLIB)/software/greth/greth_api.c
	$(XCC) -g -msoft-float -c $(GRLIB)/software/greth/greth_api.c


#mptest.o: mptest.c
#	$(XCC) -msoft-float -O -c  $<
#


lib3tests.a: $(OFILES)
	$(XAR) -cr lib3tests.a $(OFILES)

soft: prom.srec sram.srec sdram.srec $(EXTRA_SOFT)

prom.o: prom.S prom.h
	$(XAS) $<

prom.exe: prom.o
	$(XCC) -nostdlib -Tlinkprom -N -L./ -Ttext=0 -nostartfiles -o prom.exe $<

prom.srec: prom.exe
	sparc-elf-objcopy -O srec prom.exe prom.srec

systest.exe: systest.c lib3tests.a
	$(XCC) $(XCFLAGS) systest.c $(XLDFLAGS) -o systest.exe

sdram.srec: systest.exe
	sparc-elf-objcopy -O srec systest.exe sdram.srec

sram.srec: systest.exe
	sparc-elf-objcopy -O srec systest.exe sram.srec

soft-clean:
	-rm -rf *.o *.exe *.a

mmusoft:
	make -f Makefile.img mmusoft

standalone.exe: systest.c standalone.c lib3tests.a
	$(XCC) $(XCFLAGS) systest.c $(VPATH)/standalone.c $(XLDFLAGS) -o standalone.exe

