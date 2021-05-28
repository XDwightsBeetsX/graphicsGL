#version 330 core

layout (location = 0) in vec3 aPos;   // vertex info in position 0
layout (location = 1) in vec3 aColor; // RGB vector in position 1
  
out vec3 ourColor; // send color to fragment shader

void main()
{
    gl_Position = vec4(aPos, 1.0);
    ourColor = aColor;
}
