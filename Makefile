ifndef ("$(GRLIB2)")
ifdef  ("$(GRLIB)")
GRLIB2 = $(GRLIB)
else
GRLIB2 = ./
endif
endif

include bin/Makefile
# GRLIB2
#include bin/make.grlib2
#include bin/make.housekeeping
