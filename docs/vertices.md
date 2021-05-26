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

The data in `vertices[]` is simply a basic array. More information could be included than simply the coordinates of the vertices, such as RGB color values.

Because vertex data arrays are customizable, the shaders need to be instructed how to interpret the input using `glVertexAttribPointer()`.

The composition of `vertices[]` needs to be read as three sets of three *floats*, each value being *`sizeof(float)`* long.

![image](https://user-images.githubusercontent.com/55027279/119687774-14568980-be0d-11eb-85a3-b388e542f721.png)

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

Example of buffering data and setting Vertex Attributes from some data in *`vertices`* like above.

```C++
// Declare VBO and VAO IDs
unsigned int VBO, VAO;

// Generate VertexArray then Buffer
glGenVertexArrays(1, &VAO);
glGenBuffers(1, &VBO);

// Bind Vertex Array then Buffer
glBindVertexArray(VAO);
glBindBuffer(GL_ARRAY_BUFFER, VBO);

// Add 'vertices' data to Buffer
glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);

// Set Attribute of Vertex Buffer Data
// Here this is just the input points in 'vertices'
glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 3 * sizeof(float), (void*)0);
// Enable access to the Attribute
glEnableVertexAttribArray(0);

// Un-Bind the Buffer and Vertex Array
glBindBuffer(GL_ARRAY_BUFFER, 0); 
glBindVertexArray(0); 
```

For data with RGB values, the composition of `vertices[]` needs to be read as three sets of six *floats*, each value being *`sizeof(float)`* long.

![image](https://user-images.githubusercontent.com/55027279/119697364-baa68d00-be15-11eb-834c-9679edf4df45.png)

This leads to the following:

```C++
// Vertex Coordinates
glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 6 * sizeof(float), (void*)0);
glEnableVertexAttribArray(0);

// RGB Color Values
glVertexAttribPointer(1, 3, GL_FLOAT, GL_FALSE, 6 * sizeof(float), (void*)(3 * sizeof(float)));
glEnableVertexAttribArray(1);
```

- *0, 1* - configure the first and second vertex attributes
- *3* - number of values in that attribute
- *GL_FLOAT* - value type
- *GL_FALSE* - don't normalize input data
- *6 \* sizeof(float)* - stride, or space between attributes
- offset
  - *(void\*)0* - for coordinates
  - *(void\*)(3 \* sizeof(float))* - for RGB values

more on *[Vertex Array Objects (VAOs)](vao.md)* and *[Vertex Buffer Objects (VBOs)](vbo.md)*

*credit to [learnopengl.com](https://learnopengl.com)*
