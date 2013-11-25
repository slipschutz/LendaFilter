CXX=$(shell root-config --cxx)
CFLAGS=-c -g -Wall $(shell root-config --cflags) -I./src -I ./include 
LDLIBS=$(shell root-config --glibs)
LDFLAGS=$(shell root-config --ldflags)
#SOURCES=./src/SL_Event.cc ./src/FileManager.cc ./src/Filter.cc


EXTRAOBJS=$(patsubst %.cc,%.o,$(EXTRASOURCE))
EXTRAHEADS=$(patsubst %.cc,%.hh,$(EXTRASOURCE))

ROOTCINT=rootcint

NAME=Filter


temp2= $(addprefix lib,$(NAME))
LIBRARY= $(addsuffix .so,$(temp2))

OBJECT=$(addsuffix .o, $(NAME))
HEAD=$(addsuffix .hh,$(NAME))

.PHONY: clean get put all test sclean

all: $(LIBRARY) 

$(LIBRARY) : $(OBJECT) $(HEAD)
	@echo "Building Library"
	@$(CXX) `root-config --cflags` -fPIC -shared -o $@ $^
	@echo "Build succeed"
%.o : %.cc
	@echo "Compiling" $< "..."
	@$(CXX) $(CFLAGS) -fPIC $< -o $@ 

test:
	echo $(HEAD)


clean:
	-rm -f $(DICTOBJ) $(OBJECT) $(EXTRAOBJS)
	-rm -f *Dictionary.h
	-rm -f *Dictionary.cc
	-rm -f $(LIBRARY)
	-rm -f *Parsed.cc
	-rm -f *Parsed.o
sclean:
	-rm *~
	make clean