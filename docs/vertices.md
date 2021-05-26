# ***Vertices***

OpenGL uses *Normalized Device Coordinates (NDC)* such that only points within the x,y,z ranges [-1,1] will appear in the window.

<table>
    <tr>
        <th> Input Points </th>
        <th> Output </th>
    </tr>
    <tr>
<td>

```C++
// Triangle Shape
float vertices[] = {
    -0.5f, -0.5f, 0.0f,  // bottom left
     0.5f, -0.5f, 0.0f,  // bottom right
     0.0f,  0.5f, 0.0f   // top
};
```

</td>
<td>

![image](https://user-images.githubusercontent.com/55027279/119425856-c5eea100-bccd-11eb-8a7b-63d2868e6256.png)

</td>
    </tr>
</table>

Note that the data in `vertices[]` is simply a basic array. More information could be included than simply the coordinates of the vertices.

Because vertex data arrays are customizable, the shaders need to be instructed how to interpret the input using `glVertexAttribPointer()`.

The composition of `vertices[]` needs to be read as three sets of three *floats*, each one being *`sizeof(float)`* long.

<img style="display: block; margin: 20px 80px;" src="https://user-images.githubusercontent.com/55027279/119687774-14568980-be0d-11eb-85a3-b388e542f721.png"/>

This leads to the following:

```C++
glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 3 * sizeof(float), (void*)0);
```

- *0* - configure the first vertex attribute
- *3* - number of values in that attribute
- *GL_FLOAT* - value type
- *GL_FALSE* - don't normalize input data
- *3 \* sizeof(float)* - stride, or space between attributes
- *(void\*)0* - offset of position data

Binding to *[Vertex Array Object](vao.md)* first, then to the *[Vertex Buffer Object](vbo.md)*

```C++
unsigned int VBO, VAO;
glGenVertexArrays(1, &VAO);
glGenBuffers(1, &VBO);


glBindVertexArray(VAO);

glBindBuffer(GL_ARRAY_BUFFER, VBO);
glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);

glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 3 * sizeof(float), (void*)0);
glEnableVertexAttribArray(0);
```

*credit to [learnopengl.com](https://learnopengl.com)*
