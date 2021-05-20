# Makefile for C++ Graphics with OpenGL
# Author: John Gutierrez

EXE_NAME = program

CP = g++
CFLAGS = -g


all: program

program:
	$(CP) $(CFLAGS) ./src/main.cpp -o ./bin/$(EXE_NAME)

clean:
	rm ./bin/*.o
