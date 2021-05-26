# Graphics with OpenGL

**[OpenGL](https://www.opengl.org/)** provides an API for interacting with a computer's graphics. It's implementation requires the construction of an *OpenGL context* for the system in addition to the *headers* declaring function calls.

This project will use the **[GLFW](https://www.glfw.org/) + [GLAD](https://glad.dav1d.de/)** scheme for Windows. **GLFW** is compiled into a library that is system-dependent, while the **GLAD** OpenGL calls are *system-independent*.

## Usage

- Project can be built using `make all` and run with `make run`
- Rebuild with `make destroy` then `make all`

### Dependencies

1. **make / cmake**
2. **MinGW / g++**

## Overview of OpenGL

- **[OpenGL](https://www.opengl.org/)** is an API for giving instructions to a graphics card
  - Since the implementation of these commands will vary based on the system, a library must be built for the device

- The **[Graphics Library Framework (GLFW)](https://www.glfw.org/)** provides a wrapper for making a device context in order to *"create windows, contexts and surfaces, reading input, handling events, etc."*

- With a context created, the **OpenGL** methods can be executed via the **[OpenGL Extension Wrangler (GLEW)](http://glew.sourceforge.net/)** or the **[GLAD](https://glad.dav1d.de/)** interfaces that handle access to the opengl graphics driver methods

## Starting OpenGL with **GLFW + GLAD**

1. Install **[MinGW](http://mingw-w64.org/doku.php/download)** C++ Compiler

    - Add to *System Path*
        - *`<MinGW-path>/bin`*
        - *`<MinGW-path>/x86_64-w64-mingw32/bin`*

2. Install **[cmake](https://cmake.org/download/)**

    - Add to *System Path*

3. Open **cmd** or **powershell** and verify that the *System Path* can access `g++` and `make`:

    - `g++ --version`
    - `cmake --version`
    - Can also *Edit System Environnment Variables* and add *`<MinGW-path>/bin`*

4. Download **[GLFW *Source Package*](https://www.glfw.org/download.html)**

    - Download the `.zip` to a convenient location such as *`C:/dev`*
    - *Extract* the files
    - Launch the **cmake-gui**
      - change the *source code* to the unzipped directory
      - make a new folder directory like *`glfw-build`* for *destination*
      - *configure* for **MinGW** and *Generate*
    - Open ***powershell*** or ***cmd*** into this directory and run:
      - `make`
      - `make install`
    - Can also run:
      - `cmake -G "MinGW Makefiles"`
      - `cmake install`

5. Adding Lib to **MinGW**

    - Now a system-specific library has been constructed. This can either be added to the compiler *`/lib`* or pointed to in the project with `-L<project-path>/lib` during linking.
    - Navigate to the *`/lib` destination* directory
      - Copy the *`libglfw3.a`*
      - Paste into the **MinGW** directory under something like
      *`<MinGW-path>/lib`*
    - Navigate to the *`/include` destination* directory
      - Copy the `GLFW` folder with *`glfw3.h`* and *`glfw3native.h`*
      - Paste into the **MinGW** directory under something like *`<MinGW-path>/include`*
      - This folder contains the *'glfw'* function declarations in headers, which are defined in the *`libglfw3.a`* library for the system

6. Install **[GLAD](https://glad.dav1d.de/)**

    - From *`GLAD/include`*
      - Copy the *`GLAD/glad.h`* header to *`<project-path>/include/GLAD/`*
      - Copy the *`KHR/khrplatform.h`* header to *`<project-path>/include/KHR/`*
    - Add *`glad.c`* to *`src/`* or specify it's location at compile-time:

      ```shell
      g++ <project-path>/include/GLAD/glad.c -g -c -I<project-path>/include -o <project-path>/bin/glad.o
      ```

7. Verify

    The modified [sample code](https://learnopengl.com/code_viewer.php?code=getting-started/hellowindow2) below was used to verify the setup of **GLFW + GLAD**

    *NOTE: It is important to `#import`*`glad.h`*before*`glfw3.h`**

      ```C++
      #include <iostream>
      #include <GLAD/glad.h>
      #include <GLFW/glfw3.h>

      // Function prototypes
      void key_callback(GLFWwindow* window, int key, int scancode, int action, int mode);

      // Window dimensions
      const GLuint WIDTH = 800, HEIGHT = 600;

      // The MAIN function, from here we start the application and run the game loop
      int main()
      {
          std::cout << "Starting GLFW context, OpenGL 3.3" << std::endl;
          
          glfwInit();
          
          // Set all the required options for GLFW
          glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
          glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
          glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);
          glfwWindowHint(GLFW_RESIZABLE, GL_FALSE);

          // Create a GLFWwindow object that we can use for GLFW's functions
          GLFWwindow* window = glfwCreateWindow(WIDTH, HEIGHT, "LearnOpenGL", NULL, NULL);
          glfwMakeContextCurrent(window);
          if (window == NULL)
          {
              std::cout << "Failed to create GLFW window" << std::endl;
              glfwTerminate();
              return -1;
          }

          // Set the required callback functions
          glfwSetKeyCallback(window, key_callback);

          if (!gladLoadGLLoader((GLADloadproc) glfwGetProcAddress))
          {
              std::cout << "Failed to initialize OpenGL context" << std::endl;
              return -1;
          }

          // Define the viewport dimensions
          glViewport(0, 0, WIDTH, HEIGHT);

          // Game loop
          while (!glfwWindowShouldClose(window))
          {
              // Check if any events have been activated (key pressed, mouse moved etc.) and call corresponding response functions
              glfwPollEvents();

              // Render
              // Clear the colorbuffer
              glClearColor(0.2f, 0.3f, 0.3f, 1.0f);
              glClear(GL_COLOR_BUFFER_BIT);

              // Swap the screen buffers
              glfwSwapBuffers(window);
          }

          // Terminates GLFW, clearing any resources allocated by GLFW.
          glfwTerminate();
          return 0;
      }

      // Is called whenever a key is pressed/released via GLFW
      void key_callback(GLFWwindow* window, int key, int scancode, int action, int mode)
      {
          std::cout << key << std::endl;
          if (key == GLFW_KEY_ESCAPE && action == GLFW_PRESS)
              glfwSetWindowShouldClose(window, GL_TRUE);
      }
      ```

    Compiling `.o` files into `/bin` with inclusions under `-I<project-path>/include`

    Then linking with `-L<project-path>/lib`

      ```shell
      g++ <project-path>/include/GLAD/glad.c -g -c -I<project-path>/include -o <project-path>/bin/glad.o

      g++ <project-path>/src/main.cpp -g -c -I<project-path>/include -o <project-path>/bin/main.o

      g++ <project-path>/bin/*.o -g -L<project-path>/lib -lglfw3 -lopengl32 -lgdi32 -o <project-path>/bin/program
      ```
