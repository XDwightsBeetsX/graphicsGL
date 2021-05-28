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

$(TARGET): glad stbi_image main
	$(info linking...)
	$(CXX) $(BIN)/*.o -g $(LIB_FLAGS) -o $(BIN)/$(TARGET)


# For compiling the main project
main:
	$(info compiling main...)
	$(CXX) $(SRC)/main.cpp $(OBJ_FLAGS) -I$(INCLUDE) -o $(BIN)/main.o


# Examples
tri: glad tri_cpp
	$(info linking triangle...)
	$(CXX) $(BIN)/glad.o $(BIN)/basic_triangle.o -g $(LIB_FLAGS) -o $(BIN)/tri.exe
tri_cpp:
	$(info compiling triangle...)
	$(CXX) $(SRC)/basic_triangle.cpp $(OBJ_FLAGS) -I$(INCLUDE) -o $(BIN)/basic_triangle.o
run-tri:
	$(BIN)/tri.exe

cctri: glad cctri_cpp
	$(info linking color_change_triangle...)
	$(CXX) $(BIN)/glad.o $(BIN)/color_change_triangle.o -g $(LIB_FLAGS) -o $(BIN)/cctri.exe
cctri_cpp:
	$(info compiling color_change_triangle...)
	$(CXX) $(SRC)/color_change_triangle.cpp $(OBJ_FLAGS) -I$(INCLUDE) -o $(BIN)/color_change_triangle.o
run-cctri:
	$(BIN)/cctri.exe

wb: glad stbi wb_cpp
	$(info linking wood_box...)
	$(CXX) $(BIN)/glad.o $(BIN)/wood_box.o -g $(LIB_FLAGS) -o $(BIN)/wb.exe
wb_cpp:
	$(info compiling wood_box...)
	$(CXX) $(SRC)/wood_box.cpp $(OBJ_FLAGS) -I$(INCLUDE) -o $(BIN)/wood_box.o
run-wb:
	$(BIN)/wb.exe

# GLAD, required for GL calls
glad:
	$(info compiling glad...)
	$(CXX) $(INCLUDE)/GLAD/glad.c $(OBJ_FLAGS) -I$(INCLUDE) -o $(BIN)/glad.o


# STBI image loading library (for textures)
stb:
	$(info compiling stb...)
	$(CXX) $(INCLUDE)/STB/stb_image.cpp $(OBJ_FLAGS) -I$(INCLUDE) -o $(BIN)/stb.o


# MAKE commands...
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
