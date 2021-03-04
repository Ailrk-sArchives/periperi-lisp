# 1. compile ppl to x86.
# 2. compile runtime system.
# 3. link ppl to rts to get executale.

UNAME := $(shell uname)

ASM = nasm
CC = gcc
CFLAG = -Wall

ROOT = .
CBITS = $(ROOT)/cbits
SRC = $(ROOT)/src
BIN = $(ROOT)/bin
EX = $(ROOT)/example

ifeq ($(UNAME), Darwin)
  format=macho64
else
  format=elf64
endif

%.run: %.o rts.o
	$(CC) $(BIN)/*.o -o $@ $(CFLAG)

rts.o: $(CBITS)/rts.c
	$(CC) $< -c -o $(BIN)/$@ $(CFLAG)

%.o: %.s
	$(ASM) $(BIN)/$< -f $(format) -o $(BIN)/$@

%.s: %.ppl
	racket -t $(SRC)/compile-file.rkt -m $< > $(BIN)/$@

.phony: clean
clean:
	rm *.run **/*.o **/*.s **/*.run

.phony: test
test:
	@test $(shell ./42.run) = "42"
