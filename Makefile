## -*- Makefile -*-
##
## User: iurisegtovich
#
#### Compiler and tool definitions shared by all build targets #####
FC = /usr/bin/gfortran
#FC = /usr/local/bin/ifort
FCOPTS = -g -Wall -fbounds-check -cpp -fmax-errors=1 -ffree-line-length-0

# Define the target directories.
OUTPUTDIR= ./obj
SRCDIR= ./src
RUNDIR= ./run

#prerequisitos para qualqauer chamada externa
prerequisites = \
	check_Makefile \

.DEFAULT_GOAL := all
.PHONY: all roda clean

# Etiquetas aptas a serem chamadas externamente:
##compila e linka
all: $(prerequisites) $(RUNDIR)/program.elf

##compila, linka e roda
roda: all
	$(RUNDIR)/program.elf 2>&1 | tee tee.txt

#limpar projeto se o Makefile for modificado
check_Makefile: Makefile 
	touch check_Makefile
	make clean


# Compile source files into .o files

#main
$(OUTPUTDIR)/main.o: $(SRCDIR)/main.f90
	$(FC) $(FCOPTS) -J$(OUTPUTDIR) -c $(SRCDIR)/$(@F:%.o=%.f90) -o $@

# Link or archive
$(RUNDIR)/program.elf: $(OUTPUTDIR)/main.o
	$(FC) $(FCOPTS) $^ -o $@ -lgsl -lgslcblas #usar as lib da GSL na hora de linkar o program

#### Clean target deletes all generated files ####
clean:
	rm -f $(OUTPUTDIR)/*.o 
	rm -f $(OUTPUTDIR)/*.mod
	rm -f $(OUTPUTDIR)/*.a
	rm -f $(RUNDIR)/*program.elf
	
