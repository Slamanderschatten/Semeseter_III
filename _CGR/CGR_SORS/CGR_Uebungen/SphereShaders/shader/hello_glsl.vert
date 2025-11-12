uniform mat4 projectionMatrix;
uniform mat4 modelMatrix;
uniform mat4 viewMatrix;
mat4 modelViewMatrix = viewMatrix*modelMatrix;

layout (location = 0) in vec4 vertexPosition;
//Vertexposition übergeben
out vec4 vs_vPos;

void main()
{
        gl_Position = projectionMatrix*modelViewMatrix*vertexPosition;
        vs_vPos = vertexPosition;
}
