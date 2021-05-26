# ***OpenGL with GLAD + GLFW***

Graphics rendering with OpenGL generally takes the form

- **[Context Creation](#Context-Creation)**
- **[Shader Compilation](#Shaders)**
- **[Vertex Construction](#Vertices)**
- **[Texture Binding](#Textures)**
- **[Render Loop](#Render-Loop)**

## ***Context Creation***

Taken care of with ***GLFW*** methods:

```C++
#include <GLFW/glfw3.h>

void framebuffer_size_callback(GLFWwindow* window, int width, int height);
void processInput(GLFWwindow *window);

int main() {
    // Initialize
    glfwInit();
    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
    glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);

    // Window and context creation
    GLFWwindow* window = glfwCreateWindow(WIDTH, HEIGHT, "WindowTitle", NULL, NULL);
    glfwMakeContextCurrent(window);
    glfwSetFramebufferSizeCallback(window, framebuffer_size_callback);
}
```

## ***[Shaders](shaders.md)***

Shaders are written in the *OpenGL Shading Language (GLSL)* and define how to operate on inputs and outputs in the graphics pipeline.

There are three types of customizable shaders

- Vertex
- Geometry
- Fragment

## ***[Vertices](vertices.md)***

In order to apply a shader to make a shape, the shape must be defined by a series of vertices located in space. This is done by defining vertice arrays for shapes.

Note that OpenGL windows are based on *Normalized Device Coordinates (NDC)*.

Vertices should be added to a [Vertex Array Object (VAO)](vao.md) first, then bound to a [Vertex Buffer Object (VBO)](vbo.md), before fianlly defining vertex attributes.

## ***Textures***

<!-- TODO -->

## ***Render Loop***

Render loops should do the following:

- Register inputs
  - perform operations on vertices
- Clear Render
- Bind Textures
- Implement Shaders
- Draw Elements
- Update Render
- Poll for Inputs

Example:

```C++
// [in main()]
while (!glfwWindowShouldClose(window))
{
    // Evaluate recieved inputs
    processInput(window);

    // Clear the render
    glClearColor(0.2f, 0.3f, 0.3f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT);

    // Bind textures
    glBindTexture(GL_TEXTURE_2D, texture);

    // Implement shader
    ourShader.use();

    // Draw elements
    glBindVertexArray(VAO);
    glDrawElements(ELEMENTS, 6, GL_UNSIGNED_INT, 0);

    // Update to the finished back buffer when finished rendering
    glfwSwapBuffers(window);
    // Await input such as keys pressed, mouse, etc.
    glfwPollEvents();
}
```

*credit to [learnopengl.com](https://learnopengl.com)*
