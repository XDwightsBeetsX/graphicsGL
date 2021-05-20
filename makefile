# Makefile for C++ Graphics with OpenGL
# Author: John Gutierrez

# Directory business
glfw_inc = include/GLFW
glfw_lib = lib/GLFW


# Source Files
TARGET = program
BIN = bin
SRC = src

# Linking to static library files
includes_paths = $(glfw_inc)
libs_paths = $(glfw_lib)

INCLUDE_FLAGS = -I$(includes_paths)
LIB_FLAGS = -L$(libs_paths)


# Compiler
CXX = g++
CXXFLAGS = -g $(INCLUDE_FLAGS)


# MAKE
all: $(TARGET)

$(TARGET): main
	$(CXX) $(CXXFLAGS) $(BIN)/main.o -o $(BIN)/$(TARGET).exe $(LIB_FLAGS)

main:
	$(CXX) $(CXXFLAGS) -c $(SRC)/main.cpp -o $(BIN)/main.o $(LIB_FLAGS)

clean:
	rm $(BIN)/*.o

wipe:
	make clean
	rm $(BIN)/*.exe

run:
	$(BIN)/$(EXE_NAME)
