# ***Vertex Array Objects (VAOs)***

[*Vertex Buffer Objects (VBOs)*](vbo.md) are used for rendering sets of vertices which might make up some shapes. It is convenient to group *VBOs* together into an array for something like rendering a composite shape.

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

*credit to [learnopengl.com](https://learnopengl.com)*
