# Graphics with OpenGL

I will be attempting to put some shapes on the screen using the `C++` library [**OpenGL**](https://www.opengl.org/).  

This library is really an interface between the code and a computer's graphics.  

I have never used this before so just looking to get something to work...

## Usage

- Project can be built using `make all` and run with `make run`
- Rebuild with `make wipe` then `make all`

### Dependencies

1. **`make`** & **`g++`**
2. [GLFW](https://www.glfw.org/)

## Overview of OpenGL

- **[OpenGL](https://www.opengl.org/)** is an API for giving instructions to a graphics card
  - Since the implementation of these commands will vary based on the system, a library must be built for the device

- The **[Graphics Library Framework (GLFW)](https://www.glfw.org/)** provides a wrapper for making a device context in order to *"create windows, contexts and surfaces, reading input, handling events, etc."*

- With a context created, the **OpenGL** methods can be executed via the **[OpenGL Extension Wrangler (GLEW)](http://glew.sourceforge.net/)** or the **[GLAD](https://glad.dav1d.de/)** interfaces that handle access to the graphics driver methods

## Getting Started

1. Install [MinGW](http://mingw-w64.org/doku.php/download) C++ Compiler

    - Add to *System Path*
        - `C:\Program Files\MinGW\mingw64\bin`
        - `C:\Program Files\MinGW\mingw64\x86_64-w64-mingw32\bin`
    - Verify install by running `g++ --version` in ***cmd***

2. Install [CMake](https://cmake.org/download/)

    - Choose option to add *System Path*

3. Download [GLFW *Source Package*](https://www.glfw.org/download.html)

    - Download the `.zip` to a convenient location such as `C:/dev`
    - *Extract* the files
    - Launch the **cmake-gui**
      - change the *source code* to the unzipped directory
      - make a new folder directory like `glfw-build` for *destination*
    - Open ***powershell*** or ***cmd*** into this directory
    - Run `make` in the command line
    - Run `make install` in the command line

4. Adding Lib to **MinGW**

    - Now a system-specific library has been constructed
    - Navigate to the `/lib` *destination* directory
      - Copy the `libglfw3.a`
      - Paste into your **MinGW** directory under something like:
      `MinGW\mingw64\lib`
    - Navigate to the `/include` *destination* directory
      - Copy the `GLFW` folder
      - Paste into your **MinGW** directory under something like:
      `MinGW\mingw64\include`
      - This folder contains the *'glfw'* function declarations in headers, which are defined in the `libglfw3.a` library for the system

5. Verify GLFW Install

    - The [sample code](https://www.glfw.org/documentation.html#example-code) below was used to verify the setup.

      ```C++
      #include <GLFW/glfw3.h>

      int main(void)
      {
          GLFWwindow* window;

          /* Initialize the library */
          if (!glfwInit())
              return -1;

          /* Create a windowed mode window and its OpenGL context */
          window = glfwCreateWindow(640, 480, "Hello World", NULL, NULL);
          if (!window)
          {
              glfwTerminate();
              return -1;
          }

          /* Make the window's context current */
          glfwMakeContextCurrent(window);

          /* Loop until the user closes the window */
          while (!glfwWindowShouldClose(window))
          {
              /* Render here */
              glClear(GL_COLOR_BUFFER_BIT);

              /* Swap front and back buffers */
              glfwSwapBuffers(window);

              /* Poll for and process events */
              glfwPollEvents();
          }

          glfwTerminate();
          return 0;
      }

    Compiled with

      ```shell
      g++ src/main.cpp -g -c -IH:/dev/graphicsGL/include -o bin/main.o
      g++ bin/main.o -g -LH:/dev/graphicsGL/lib/GLFW -lglfw3 -lopengl32 -lgdi32 -o bin/program
      ```
