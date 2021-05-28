#version 330 core
 
in vec3 ourColor;  // take in color from triangle-shader.vs

out vec4 FragColor;  // output the color

void main()
{
    FragColor = vec4(ourColor, 1.0);
}
