# Graphics with OpenGL

I will be attempting to put some shapes on the screen using the `C++` library [**OpenGL**](https://www.opengl.org/).  

This library is really an interface between the code and a computer's graphics.  

I have never used this before so just looking to get something to work...

## Usage

Project can be built using `make all` and run under `\bin` with `make run`  

Issues can sometimes be solve by rebuilding with `make clean` then `make all`  

## Overview

- Core OpenGL (GL)
  - Contains geometry functions with prefix *"gl"*
- OpenGL Utility Library (GLU)
  - Modelling functions with prefix *"glu"*
- OpenGL Utilities Toolkit (GLUT)
  - Interfaces with Operating system to create windows. Prefixed by *"glut"*
- OpenGL Extension Wrangler Library [(GLEW)]((http://glew.sourceforge.net/install.html))
  - Determines which OpenGL extensions are supported on a platform

### Components

Each of these libraries contains several parts that must be availiable to the program for compiling.

- *header* file
- *static library*
- optional *shared library*

## How I Started

1. Install [MinGW](http://mingw-w64.org/doku.php/download) C++ Compiler

    - Add to *System Path*
        - `C:\Program Files\MinGW\mingw64\bin`
        - `C:\Program Files\MinGW\mingw64\x86_64-w64-mingw32\bin`
    - Verify install by running `g++ --version` in *cmd.exe*

2. Setup [GLFW](https://www.glfw.org/download.html)

    - Download `.zip` and move following:
        - `glfw3.h` to `/include/GLFW`
        - `glfw3native.h` to `/include/GLFW`
        - `glfw3.lib` to `/lib/GLFW`

> *[startup sample](https://www.glfw.org/documentation.html#example-code)*  
