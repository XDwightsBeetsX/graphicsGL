# Makefile for C++ Graphics with OpenGL
# Author: John Gutierrez


# Source Files
HOME = H:/dev/graphicsGL
TARGET = program

BIN = $(HOME)/bin
SRC = $(HOME)/src
INCLUDE = $(HOME)/include
LIB = $(HOME)/lib


# Compiler
CXX = g++
OBJ_FLAGS = -g -c


# Linking to static library files
LIB_FLAGS = -L$(LIB) -lglfw3 -lopengl32 -lgdi32


# MAKE
all: $(TARGET)

$(TARGET): glad.o main.o
	$(info linking...)
	$(CXX) $(BIN)/*.o -g $(LIB_FLAGS) -o $(BIN)/$(TARGET)

glad.o: $(INCLUDE)/GLAD/glad.c
	$(info compiling glad...)
	$(CXX) $(INCLUDE)/GLAD/glad.c $(OBJ_FLAGS) -I$(INCLUDE) -o $(BIN)/glad.o

main.o: $(SRC)/main.cpp
	$(info compiling main...)
	$(CXX) $(SRC)/main.cpp $(OBJ_FLAGS) -I$(INCLUDE) -o $(BIN)/main.o

clean:
	rm $(BIN)/*.o

destroy:
	rm $(BIN)/*

rebuild:
	make destroy
	make all

run:
	$(BIN)/$(TARGET).exe

.PHONY: all clean destroy run
