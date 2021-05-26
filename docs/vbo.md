# ***Vertex Buffer Objects (VBOs)***

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

*credit to [learnopengl.com](https://learnopengl.com)*
