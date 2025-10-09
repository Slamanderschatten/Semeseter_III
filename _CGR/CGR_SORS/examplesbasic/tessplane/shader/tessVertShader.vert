layout (location = 0) in vec4 vertexPosition;
in vec2 textureCoords;

out vec4 vPosition;
out vec2 vTexCoords;

void main()
{
    vPosition = vertexPosition;
    vTexCoords=textureCoords;
}
