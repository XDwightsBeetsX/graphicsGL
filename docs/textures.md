# ***Textures in OpenGL***

Similar to how [shaders](shaders.md) are applied to a [Vertex Array Object (VAO)](vao.md), textures are bound

## ***Creating a Texture Object***

```C++
// Reserve ID for texture
unsigned int texture;

// Generate 1 texture object
glGenTextures(1, &texture);

// Set this texture object as the active one
glBindTexture(GL_TEXTURE_2D, texture);

// Set texture parameters
glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
```

## ***Loading a Texture Image***

Using the **[stb_image](https://github.com/nothings/stb/blob/master/stb_image.h)** library for texture image loading,

```C++
// In stb_image.cpp
#define STB_IMAGE_IMPLEMENTATION
#include "stb_image.h"
```

Implementation,

```C++
// load and generate the texture
int width, height, nrChannels;
unsigned char *data = stbi_load("container.jpg", &width, &height, &nrChannels, 0);

// Generates the texture image to the currently bound texture object
glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, width, height, 0, GL_RGB, GL_UNSIGNED_BYTE, data);

// Generates all the necesary mipmap levels
glGenerateMipmap(GL_TEXTURE_2D);

stbi_image_free(data);
```
