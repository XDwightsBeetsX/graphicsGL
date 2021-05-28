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
triangle: glad t_cpp
	$(info linking triangle...)
	$(CXX) $(BIN)/glad.o $(BIN)/triangle.o -g $(LIB_FLAGS) -o $(BIN)/triangle.exe
t_cpp:
	$(info compiling triangle...)
	$(CXX) $(SRC)/triangle.cpp $(OBJ_FLAGS) -I$(INCLUDE) -o $(BIN)/triangle.o


color-changer: glad cch_cpp
	$(info linking color-changer...)
	$(CXX) $(BIN)/glad.o $(BIN)/color-changer.o -g $(LIB_FLAGS) -o $(BIN)/color-changer.exe
cch_cpp:
	$(info compiling color-changer...)
	$(CXX) $(SRC)/color-changer.cpp $(OBJ_FLAGS) -I$(INCLUDE) -o $(BIN)/color-changer.o


triangle-shaders: glad ts_cpp
	$(info linking triangle-shaders...)
	$(CXX) $(BIN)/glad.o $(BIN)/triangle-shaders.o -g $(LIB_FLAGS) -o $(BIN)/triangle-shaders.exe
ts_cpp: # Note change in include dir to -I$(HOME)
	$(info compiling triangle-shaders...)
	$(CXX) $(SRC)/triangle-shaders.cpp $(OBJ_FLAGS) -I$(HOME) -o $(BIN)/triangle-shaders.o


wood-container: glad wc_cpp
	$(info linking wood-container...)
	$(CXX) $(BIN)/glad.o $(BIN)/wood-container.o -g $(LIB_FLAGS) -o $(BIN)/wood-container.exe
wc_cpp:
	$(info compiling wood-container...)
	$(CXX) $(SRC)/wood-container.cpp $(OBJ_FLAGS) -I$(INCLUDE) -o $(BIN)/wood-container.o


# GLAD, required for GL calls
glad: $(INCLUDE)/GLAD/glad.h
	$(info compiling glad...)
	$(CXX) $(INCLUDE)/GLAD/glad.c $(OBJ_FLAGS) -o $(BIN)/glad.o


# STBI image loading library (for textures)
stbi_image: $(INCLUDE)/STB/stb_image.h
	$(info compiling stbi_image...)
	$(CXX) $(INCLUDE)/STB/stb_image.cpp $(OBJ_FLAGS) -o $(BIN)/stb_image.o


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
