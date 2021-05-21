# Makefile for C++ Graphics with OpenGL
# Author: John Gutierrez

# Source Files
TARGET = program
BIN = bin
SRC = src


# Linking to static library files
INCLUDE = H:/dev/graphicsGL/include
LIB_DIR = H:/dev/graphicsGL/lib/GLFW
LIB_FLAGS = -lglfw3 -lopengl32 -lgdi32


# Compiler
CXX = g++
CXXFLAGS = -g -L$(LIB_DIR)
OBJ_FLAGS = -g -c -I$(INCLUDE)


# MAKE
all: $(TARGET)

$(TARGET): main.o
	$(info linking...)
	$(CXX) $(BIN)/main.o $(CXXFLAGS) $(LIB_FLAGS) -o $(BIN)/$(TARGET)

main.o: $(SRC)/main.cpp
	$(info compiling object files...)
	$(CXX) $(SRC)/main.cpp $(OBJ_FLAGS) -o $(BIN)/main.o

.PHONY: clean
clean:
	rm $(BIN)/*.o

wipe:
	make clean
	rm $(BIN)/*.exe

run:
	$(BIN)/$(TARGET).exe
