# Graphics with OpenGL

**[OpenGL](https://www.opengl.org/)** provides an API for interacting with a computer's graphics. It's implementation requires the construction of an *OpenGL context* for the system in addition to the *headers* declaring function calls.

This project will use the **[GLFW](https://www.glfw.org/) + [GLAD](https://glad.dav1d.de/)** scheme for Windows. **GLFW** is compiled into a library that is system-dependent, while the **GLAD** OpenGL calls are *system-independent*.

## Usage

- Project can be built using `make all` and run with `make run`
- `make rebuild`
- `make clean` - removes *`bin/*.o`* files

### Dependencies

1. **make**
2. **MinGW g++**
3. **cmake** for install

#### ***[See Examples](#Examples)***

## [Overview of OpenGL](docs/use.md)

- **OpenGL** is an API for giving instructions to a graphics card
  - Since the implementation of these commands will vary based on the system, a library must be built for the device

- The **Graphics Library Framework (GLFW)** provides a wrapper for making a device context in order to *"create windows, contexts and surfaces, reading input, handling events, etc."*

- With a context created, the **OpenGL** methods can be executed via the **[OpenGL Extension Wrangler (GLEW)](http://glew.sourceforge.net/)** or the **GLAD** interfaces that handle access to the opengl graphics driver methods

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
      - *Configure* for **MinGW** and *Generate*
    - Open ***powershell*** or ***cmd*** into this directory and run:
      - `make`
      - `make install`
    - Can also run:
      - `cmake -G "MinGW Makefiles"`
      - `cmake install`

5. Adding Lib to **MinGW**

    - Now a system-specific library has been constructed. This can either be added to the compiler *`/lib`* or pointed to in the project with `-L$(PROJECT)/lib` during linking.
    - Navigate to the *`/lib` destination* directory
      - Copy the *`libglfw3.a`*
      - Paste into the **MinGW** directory under something like
      *`<MinGW-path>/lib`*
    - Navigate to the *`/include` destination* directory
      - Copy the `GLFW` folder with *`glfw3.h`* and *`glfw3native.h`*
      - Paste into the **MinGW** directory under something like *`<MinGW-path>/include`*
      - This folder contains the *'glfw'* function declarations in headers, which are defined in the *`libglfw3.a`* library for the system

6. Install **GLAD**

    - From *`GLAD/include`*
      - Copy the *`GLAD/glad.h`* header to *`$(PROJECT)/include/GLAD/`*
      - Copy the *`KHR/khrplatform.h`* header to *`$(PROJECT)/include/KHR/`*
    - Add *`glad.c`* to *`src/`* or specify it's location at compile-time:

      ```shell
      g++ $(PROJECT)/include/GLAD/glad.c -g -c -I$(PROJECT)/include -o $(PROJECT)/bin/glad.o
      ```

7. **Verify**

    The modified [sample code](https://learnopengl.com/code_viewer_gh.php?code=src/1.getting_started/2.1.hello_triangle/hello_triangle.cpp) below was used to verify the **GLFW + GLAD** setup

    *NOTE: It is important to* `#include` `glad.h` *before* `glfw3.h`

      ```C++
      #include <GLAD/glad.h>
      #include <GLFW/glfw3.h>

      #include <iostream>

      void framebuffer_size_callback(GLFWwindow* window, int width, int height);
      void processInput(GLFWwindow *window);

      // settings
      const unsigned int SCR_WIDTH = 800;
      const unsigned int SCR_HEIGHT = 600;

      const char *vertexShaderSource = "#version 330 core\n"
          "layout (location = 0) in vec3 aPos;\n"
          "void main()\n"
          "{\n"
          "   gl_Position = vec4(aPos.x, aPos.y, aPos.z, 1.0);\n"
          "}\0";
      const char *fragmentShaderSource = "#version 330 core\n"
          "out vec4 FragColor;\n"
          "void main()\n"
          "{\n"
          "   FragColor = vec4(1.0f, 0.5f, 0.2f, 1.0f);\n"
          "}\n\0";

      int main()
      {
          // glfw: initialize and configure
          // ------------------------------
          glfwInit();
          glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
          glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
          glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);

      #ifdef __APPLE__
          glfwWindowHint(GLFW_OPENGL_FORWARD_COMPAT, GL_TRUE);
      #endif

          // glfw window creation
          // --------------------
          GLFWwindow* window = glfwCreateWindow(SCR_WIDTH, SCR_HEIGHT, "LearnOpenGL", NULL, NULL);
          if (window == NULL)
          {
              std::cout << "Failed to create GLFW window" << std::endl;
              glfwTerminate();
              return -1;
          }
          glfwMakeContextCurrent(window);
          glfwSetFramebufferSizeCallback(window, framebuffer_size_callback);

          // glad: load all OpenGL function pointers
          // ---------------------------------------
          if (!gladLoadGLLoader((GLADloadproc)glfwGetProcAddress))
          {
              std::cout << "Failed to initialize GLAD" << std::endl;
              return -1;
          }


          // build and compile our shader program
          // ------------------------------------
          // vertex shader
          unsigned int vertexShader = glCreateShader(GL_VERTEX_SHADER);
          glShaderSource(vertexShader, 1, &vertexShaderSource, NULL);
          glCompileShader(vertexShader);
          // check for shader compile errors
          int success;
          char infoLog[512];
          glGetShaderiv(vertexShader, GL_COMPILE_STATUS, &success);
          if (!success)
          {
              glGetShaderInfoLog(vertexShader, 512, NULL, infoLog);
              std::cout << "ERROR::SHADER::VERTEX::COMPILATION_FAILED\n" << infoLog << std::endl;
          }
          // fragment shader
          unsigned int fragmentShader = glCreateShader(GL_FRAGMENT_SHADER);
          glShaderSource(fragmentShader, 1, &fragmentShaderSource, NULL);
          glCompileShader(fragmentShader);
          // check for shader compile errors
          glGetShaderiv(fragmentShader, GL_COMPILE_STATUS, &success);
          if (!success)
          {
              glGetShaderInfoLog(fragmentShader, 512, NULL, infoLog);
              std::cout << "ERROR::SHADER::FRAGMENT::COMPILATION_FAILED\n" << infoLog << std::endl;
          }
          // link shaders
          unsigned int shaderProgram = glCreateProgram();
          glAttachShader(shaderProgram, vertexShader);
          glAttachShader(shaderProgram, fragmentShader);
          glLinkProgram(shaderProgram);
          // check for linking errors
          glGetProgramiv(shaderProgram, GL_LINK_STATUS, &success);
          if (!success) {
              glGetProgramInfoLog(shaderProgram, 512, NULL, infoLog);
              std::cout << "ERROR::SHADER::PROGRAM::LINKING_FAILED\n" << infoLog << std::endl;
          }
          glDeleteShader(vertexShader);
          glDeleteShader(fragmentShader);

          // set up vertex data (and buffer(s)) and configure vertex attributes
          // ------------------------------------------------------------------
          float vertices[] = {
              -0.5f, -0.5f, 0.0f, // left  
              0.5f, -0.5f, 0.0f, // right 
              0.0f,  0.5f, 0.0f  // top   
          }; 

          unsigned int VBO, VAO;
          glGenVertexArrays(1, &VAO);
          glGenBuffers(1, &VBO);
          // bind the Vertex Array Object first, then bind and set vertex buffer(s), and then configure vertex attributes(s).
          glBindVertexArray(VAO);

          glBindBuffer(GL_ARRAY_BUFFER, VBO);
          glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);

          glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 3 * sizeof(float), (void*)0);
          glEnableVertexAttribArray(0);

          // note that this is allowed, the call to glVertexAttribPointer registered VBO as the vertex attribute's bound vertex buffer object so afterwards we can safely unbind
          glBindBuffer(GL_ARRAY_BUFFER, 0); 

          // You can unbind the VAO afterwards so other VAO calls won't accidentally modify this VAO, but this rarely happens. Modifying other
          // VAOs requires a call to glBindVertexArray anyways so we generally don't unbind VAOs (nor VBOs) when it's not directly necessary.
          glBindVertexArray(0); 


          // uncomment this call to draw in wireframe polygons.
          //glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);

          // render loop
          // -----------
          while (!glfwWindowShouldClose(window))
          {
              // input
              // -----
              processInput(window);

              // render
              // ------
              glClearColor(0.2f, 0.3f, 0.3f, 1.0f);
              glClear(GL_COLOR_BUFFER_BIT);

              // draw our first triangle
              glUseProgram(shaderProgram);
              glBindVertexArray(VAO); // seeing as we only have a single VAO there's no need to bind it every time, but we'll do so to keep things a bit more organized
              glDrawArrays(GL_TRIANGLES, 0, 3);
              // glBindVertexArray(0); // no need to unbind it every time 
      
              // glfw: swap buffers and poll IO events (keys pressed/released, mouse moved etc.)
              // -------------------------------------------------------------------------------
              glfwSwapBuffers(window);
              glfwPollEvents();
          }

          // optional: de-allocate all resources once they've outlived their purpose:
          // ------------------------------------------------------------------------
          glDeleteVertexArrays(1, &VAO);
          glDeleteBuffers(1, &VBO);
          glDeleteProgram(shaderProgram);

          // glfw: terminate, clearing all previously allocated GLFW resources.
          // ------------------------------------------------------------------
          glfwTerminate();
          return 0;
      }

      // process all input: query GLFW whether relevant keys are pressed/released this frame and react accordingly
      // ---------------------------------------------------------------------------------------------------------
      void processInput(GLFWwindow *window)
      {
          if (glfwGetKey(window, GLFW_KEY_ESCAPE) == GLFW_PRESS)
              glfwSetWindowShouldClose(window, true);
      }

      // glfw: whenever the window size changed (by OS or user resize) this callback function executes
      // ---------------------------------------------------------------------------------------------
      void framebuffer_size_callback(GLFWwindow* window, int width, int height)
      {
          // make sure the viewport matches the new window dimensions; note that width and 
          // height will be significantly larger than specified on retina displays.
          glViewport(0, 0, width, height);
      }
      ```

    Compiling `.o` files into *`/bin`* with inclusions under `-I$(PROJECT)/include`

    Then linking with `-L$(PROJECT)/lib`

      ```shell
      g++ $(PROJECT)/include/GLAD/glad.c -g -c -I$(PROJECT)/include -o $(PROJECT)/bin/glad.o

      g++ $(PROJECT)/src/main.cpp -g -c -I$(PROJECT)/include -o $(PROJECT)/bin/main.o

      g++ $(PROJECT)/bin/*.o -g -L$(PROJECT)/lib -lglfw3 -lopengl32 -lgdi32 -o $(PROJECT)/bin/program
      ```

    **Result**

    ![image](https://user-images.githubusercontent.com/55027279/119699326-a82d5300-be17-11eb-9eff-f6aaad91cc2c.png)

## ***Examples***

- [Basic Triangle](#Basic-Triangle)
- [Color-Shifting Triangle](#Color-Shifting-Triangle)
- [Custom Shader Triangle](#Custom-Shader-Triangle)
- [Custom Texture Shader](#Custom-Texture-Shader)

### **Basic Triangle**

```shell
make triangle
./bin/triangle.exe
```

![image](https://user-images.githubusercontent.com/55027279/119914796-ab633480-bf26-11eb-8261-3f26d352093f.png)

### **Color-Shifting Triangle**

```shell
make color-changer
./bin/color-changer.exe
```

![color-changer](https://user-images.githubusercontent.com/55027279/119915384-03e70180-bf28-11eb-801e-f33014b2cacd.gif)

### **Custom Shader Triangle**

```shell
make triangle-shaders
./bin/triangle-shaders.exe
```

![image](https://user-images.githubusercontent.com/55027279/119915501-4577ac80-bf28-11eb-9caa-70999a5d4f0e.png)

### **Custom Texture Shader**

```shell

```

![image]()

*credit to [learnopengl.com](https://learnopengl.com)*
