VPATH=$(GRLIB)/software/leon3
XCC=sparc-elf-gcc -I$(GRLIB)/software/leon3 $(BOPT)
XAS=sparc-elf-gcc -c -I. -I$(GRLIB)/software/leon3 $(BOPT)
XAR=sparc-elf-ar
XCFLAGS=-O2 -g -msoft-float
XLDFLAGS=-L./ lib3tests.a $(LDFLAGS)

PROGS = report_device apbuart divtest multest regtest \
	cache gpio ramfill ramtest irqmp leon3_test gptimer \
	mulasm cacheasm spwtest mptest fpu grfpu_ops \
	base_test grfpu_test can_oc mmu mmu_asm pcitest greth atactrl \
	amba dsu3 greth_api grcan \
	spictrl i2cmst misc spimctrl svgactrl apbps2 \
	i2cslv i2c l2c \
	grusbdc rt_1553 brm_1553 pcif grtc grtm satcan memscrub_test \
	ftahbram ftlib ftsrctrl ftmctrl bch l2timers l2irqctrl leon2_test \
	grpwm grhcan brm grusbhc leon4_test base_test4 griommu l4stat ftddr2spa \
	router greth_throughput grpci2 gr1553b_test spwrouter \
	cgtest

FPROGS=$(shell for i in $(PROGS); do \
			if [ -r $(GRLIB)/software/leon3/$$i.c -o -r $(GRLIB)/software/leon3/$$i.S ]; then \
				echo $$i; \
			fi; \
		done; \
		if [ -r $(GRLIB)/software/greth/greth_api.c ]; then \
			echo greth_api; \
		fi)
FPROGS+=$(EXTRA_PROGS)

OFILES = $(FPROGS:%=%.o)

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

cgtest.o : cgtest.c
	$(XCC) -c  $<

#mptest.o: mptest.c
#	$(XCC) -msoft-float -O -c  $<
#


lib3tests.a: $(OFILES)
	$(XAR) -cr lib3tests.a $(OFILES)

soft: prom.srec sram.srec sdram.srec $(EXTRA_SOFT)

prom.o: prom.S prom.h
	$(XAS) $<
prom.exe: prom.o
	$(XCC) -nostdlib -Tlinkprom -N -L./ -nostartfiles -o prom.exe $<

prom.srec: prom.exe
	sparc-elf-objcopy -O srec prom.exe prom.srec

systest.exe: systest.c lib3tests.a
	$(XCC) $(XCFLAGS) systest.c $(XLDFLAGS) -o systest.exe

sdram.srec: systest.exe
	sparc-elf-objcopy -O srec --gap-fill 0 systest.exe sdram.srec

sram.srec: systest.exe
	sparc-elf-objcopy -O srec systest.exe sram.srec

soft-clean: gen_hex_clean
	-rm -rf *.o *.exe *.a

mmusoft:
	make -f Makefile.img mmusoft

standalone.exe: systest.c standalone.c lib3tests.a
	$(XCC) $(XCFLAGS) systest.c $(VPATH)/standalone.c $(XLDFLAGS) -o standalone.exe

gen_hex: soft
	sparc-elf-objdump -D prom.exe > prom.disas	
	sparc-elf-objdump -D systest.exe > systest.disas	  
	cp sdram.srec sdram.hex	
	sed -i '1d' sdram.hex	
	sed -i '$$d' sdram.hex	
	sed -i 's/\(.\{12\}\)//' sdram.hex	
	sed -i 's ...$$  ' sdram.hex	
	sed -i -e 's/.\{16\}/&\n/g' sdram.hex	
	sed -i '/^$$/d' sdram.hex	
	sed -i '/\n/!G;s/\(.\)\(.*\n\)/&\2\1/;//D;s/.//' sdram.hex	
	sed -i 's/\(.\)\(.\)/\2\1/g' sdram.hex

gen_hex_dim: gen_hex
	awk '{print}END{for (i=0; i < 9; i++) print "0000000000000000"}' sdram.hex > sdram_ext.hex 
	sed -n ';1~8p' sdram_ext.hex > sdram_dimm1.hex	
	sed -n ';2~8p' sdram_ext.hex > sdram_dimm2.hex	
	sed -n ';3~8p' sdram_ext.hex > sdram_dimm3.hex	
	sed -n ';4~8p' sdram_ext.hex > sdram_dimm4.hex	
	sed -n ';5~8p' sdram_ext.hex > sdram_dimm5.hex	
	sed -n ';6~8p' sdram_ext.hex > sdram_dimm6.hex	
	sed -n ';7~8p' sdram_ext.hex > sdram_dimm7.hex	
	sed -n ';8~8p' sdram_ext.hex > sdram_dimm8.hex
	pr -tmJ sdram_dimm8.hex sdram_dimm7.hex sdram_dimm6.hex sdram_dimm5.hex sdram_dimm4.hex sdram_dimm3.hex sdram_dimm2.hex sdram_dimm1.hex  > sdram_dimm_merge.hex	
	sed -i -e 's/\s\+//g' sdram_dimm_merge.hex	
	sed -i '/^$$/d' sdram_dimm_merge.hex	

gen_hex16: soft
	sparc-elf-objdump -D prom.exe > prom.disas	
	sparc-elf-objdump -D systest.exe > systest.disas	  
	cp sdram.srec sdram.hex	
	sed -i '1d' sdram.hex	
	sed -i '$$d' sdram.hex	
	sed -i 's/\(.\{12\}\)//' sdram.hex	
	sed -i 's ...$$  ' sdram.hex	
	sed -i -e 's/.\{16\}/&\n/g' sdram.hex	
	sed -i '/^$$/d' sdram.hex	
	sed -i '/\n/!G;s/\(.\)\(.*\n\)/&\2\1/;//D;s/.//' sdram.hex	
	sed -i 's/\(.\)\(.\)/\2\1/g' sdram.hex
# AHB2MIG_ML605 FIX (Order for Big Endieen isn't not correct)
	sed -i 's/\(.\)\(.\)\(.\)\(.\)/\3\4\1\2/g' sdram.hex

gen_hex_dim16: gen_hex16
	awk '{print}END{for (i=0; i < 128; i++) print "0000000000000000"}' sdram.hex > sdram_ext.hex 
	sed -i 's/..../&\n/g' sdram_ext.hex	
	sed -i -e 's/\s\+//g' sdram_ext.hex	
	sed -i '/^$$/d' sdram_ext.hex	
	sed -n ';1~4p' sdram_ext.hex > sdram_dimm4_tmp.hex	
	sed -n ';2~4p' sdram_ext.hex > sdram_dimm3_tmp.hex	
	sed -n ';3~4p' sdram_ext.hex > sdram_dimm2_tmp.hex	
	sed -n ';4~4p' sdram_ext.hex > sdram_dimm1_tmp.hex	
	sed -i '/^$$/d' sdram_dimm*_tmp.hex	
	awk 'BEGIN{FS="\n"; OFS="\n"; RS="</Fine>\n"}{for (i = 0; i <= NF/8-1; i++) print $$(8+i*8),$$(7+i*8),$$(6+i*8),$$(5+i*8),$$(4+i*8),$$(3+i*8),$$(2+i*8),$$(1+i*8)}' sdram_dimm4_tmp.hex > sdram_dimm4_test.hex	
	awk 'BEGIN{FS="\n"; OFS="\n"; RS="</Fine>\n"}{for (i = 0; i <= NF/8-1; i++) print $$(8+i*8),$$(7+i*8),$$(6+i*8),$$(5+i*8),$$(4+i*8),$$(3+i*8),$$(2+i*8),$$(1+i*8)}' sdram_dimm3_tmp.hex > sdram_dimm3_test.hex	
	awk 'BEGIN{FS="\n"; OFS="\n"; RS="</Fine>\n"}{for (i = 0; i <= NF/8-1; i++) print $$(8+i*8),$$(7+i*8),$$(6+i*8),$$(5+i*8),$$(4+i*8),$$(3+i*8),$$(2+i*8),$$(1+i*8)}' sdram_dimm2_tmp.hex > sdram_dimm2_test.hex	
	awk 'BEGIN{FS="\n"; OFS="\n"; RS="</Fine>\n"}{for (i = 0; i <= NF/8-1; i++) print $$(8+i*8),$$(7+i*8),$$(6+i*8),$$(5+i*8),$$(4+i*8),$$(3+i*8),$$(2+i*8),$$(1+i*8)}' sdram_dimm1_tmp.hex > sdram_dimm1_test.hex	
	sed -e :a -e '$!N; s/\n//; ta' sdram_dimm4_test.hex > sdram_dimm_merge1.hex
	sed -e :a -e '$!N; s/\n//; ta' sdram_dimm3_test.hex > sdram_dimm_merge2.hex
	sed -e :a -e '$!N; s/\n//; ta' sdram_dimm2_test.hex > sdram_dimm_merge3.hex
	sed -e :a -e '$!N; s/\n//; ta' sdram_dimm1_test.hex > sdram_dimm_merge4.hex
	sed -i 's/.\{32\}/&\n/g' sdram_dimm_merge1.hex	
	sed -i 's/.\{32\}/&\n/g' sdram_dimm_merge2.hex	
	sed -i 's/.\{32\}/&\n/g' sdram_dimm_merge3.hex	
	sed -i 's/.\{32\}/&\n/g' sdram_dimm_merge4.hex	

gen_hex_clean:
	-rm -f *.hex *.disas