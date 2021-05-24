#include <iostream>

// glad FIRST, THEN glfw
#include <GLAD/glad.h>
#include <GLFW/glfw3.h>


int main(void)
{
    // Initialise GLFW
    if( !glfwInit() )
    {
        fprintf( stderr, "Failed to initialize GLFW\n" );
        return -1;
    }
    
    GLFWwindow* window = glfwCreateWindow(800, 600, "Lab3", NULL, NULL);
    if (window == NULL)
    {
        std::cout << "Failed to create GLFW window" << std::endl;
    }

    glfwMakeContextCurrent( window );

    if (!gladLoadGLLoader((GLADloadproc)glfwGetProcAddress))
    {
        std::cout << "Failed to initialize GLAD" << std::endl;
    }
}