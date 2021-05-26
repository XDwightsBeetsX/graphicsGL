# ***Shaders in OpenGL***

The process of converting a set of 3D coordinates to 2D pixels on a screen involves a series of transformations via the *graphics pipeline*

![image](https://user-images.githubusercontent.com/55027279/119664302-cdf72f80-bdf8-11eb-8eb4-d0d8d65b2503.png)

where blue stages are those where the user can implement custom shaders.

With the exception of the *Vertex Shader* (which gets its input directly from vertex data), inputs and outputs to the shader methods must be declared.

This, and the implementation of the methods is done in the *OpenGL Shading Language (GLSL)*.

## ***GLSL***

All shaders must define the following

- *version*
- *input*
- *output*
- *main()*

### ***Vertex Shader***

```C++
#version 330 core

// the position variable has attribute position 0
layout (location = 0) in vec3 aPos;

// input does not need to be defined for vertex shaders

// specify a color output to the fragment shader
out vec4 vertexColor;

void main()
{
    // directly give vec3 to vec4's constructor
    gl_Position = vec4(aPos, 1.0);

    // set the output variable to a dark-red color
    vertexColor = vec4(0.5, 0.0, 0.0, 1.0);
}
```

### ***Fragment Shader***

```C++
#version 330 core

out vec4 FragColor;

// the input variable from the vertex shader (same name and same type)  
in vec4 vertexColor;

void main()
{
    FragColor = vertexColor;
} 
```

### ***Uniforms***

In addition to the shader *input*, more data can be passed into a shader via *uniforms*.

*Uniforms* are global variables that are set in OpenGL code via a series of method calls:

```C++
// Get location of shader and uniform name
// Will return -1 if not found
int vertexLocation = glGetUniformLocation(shaderProgram, "uniformVariable");

// Set shaderProgram as the active shader
glUseProgram(shaderProgram);

// Set the uniform value
glUniform4f(vertexLocation, 0.0f, uniformVariableValue, 0.0f, 1.0f);
```

*glUniform* is "overloaded" in a way where the postfix determines the type of uniform to be set. Here *uniformVariable* is a vec4 of floats, hence *<4f>*.

Some other postfixes

- *f* - the function expects a float
- *i* - the function expects an int
- *ui* - the function expects an unsigned int
- *3f* - the function expects 3 floats
- *fv* - the function expects a float vector/array

*credit to [learnopengl.com](https://learnopengl.com)*
