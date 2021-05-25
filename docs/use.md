# OpenGL with **GLAD + GLFW**

OpenGL objects are handled by  unique IDs.

## Vertices

OpenGL uses *Normalized Device Coordinates (NDC)* such that only points within the x,y,z ranges [-1,1] will appear in the window.

<table>
    <tr>
        <th> Input Points </th>
        <th> Output </th>
    </tr>
    <tr>
<td>

```C++
float vertices[] = {
    -0.5f, -0.5f, 0.0f,
    0.5f, -0.5f, 0.0f,
    0.0f,  0.5f, 0.0f
};
```

</td>
<td>

![image](https://user-images.githubusercontent.com/55027279/119425856-c5eea100-bccd-11eb-8a7b-63d2868e6256.png)

</td>
    </tr>
</table>

## Vertex Buffer Objects (VBOs)

Making a request to the graphics card for every vertex is very slow. To improve performace, vertices are added to a *Vertex Buffer Object* which is then sent to the graphics card with a large batch of points.

Generating the *ID* for a *VBO*,

```C++
unsigned int VBO;
glGenBuffers(1, &VBO);
```

*VBO*s are of type *GL_ARRAY_BUFFER*. The previously declared *VBO* can be bound to the *GL_ARRAY_BUFFER* target so that calls made to *GL_ARRAY_BUFFER* can configure the *VBO*.

```C++
glBindBuffer(GL_ARRAY_BUFFER);
```

Finally a request can be made to buffer the data to the graphics card,

```C++
glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);
```

With arguments:

1. type of buffer to bind data into
2. size of data being bound in bytes
3. data to be bound
4. how to manage the sent data

    - *GL_STREAM_DRAW* - the data is set only once and used by the GPU at most a few times
    - *GL_STATIC_DRAW* - the data is set only once and used many times
    - *GL_DYNAMIC_DRAW* - the data is changed a lot and used many times

## Shaders

a

## Vertex Array Objects (VAOs)

*VBOs* are used for rendering sets of vertices which might make up some shapes. It is convenient to group *VBOs* together into an one or more *VBO* objects in an array for something like rendering a composite shape.

*VAOs* contain information about *VBO* objects and can be easily used by binding to the corresponding *VBO* before drawing the object.

```C++
// Init VAO
unsigned int VAO;
glGenVertexArrays(1, &VAO);

// 1. bind Vertex Array Object
glBindVertexArray(VAO);

// 2. copy our vertices array in a buffer for OpenGL to use
glBindBuffer(GL_ARRAY_BUFFER, VBO);
glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);

// 3. then set our vertex attributes pointers
glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 3 * sizeof(float), (void*)0);
glEnableVertexAttribArray(0);

[...]

// Drawing code (in render loop)
// 4. draw the object
glUseProgram(shaderProgram);
glBindVertexArray(VAO);
someOpenGLFunctionThatDrawsOurTriangle();
```

*credit to [learnopengl.com](https://learnopengl.com/Getting-started/OpenGL)*
