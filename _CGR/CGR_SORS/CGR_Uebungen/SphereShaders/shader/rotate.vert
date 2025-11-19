in vec3 vertexPosition;
in vec3 vertexColor;

uniform float Time;
uniform mat4 Rotation;

uniform mat4 projectionMatrix;
uniform mat4 modelMatrix;
uniform mat4 viewMatrix;

out vec4 vs_vPos;

void main()
{
    /*
    //Rotationsmatrix um die Y-Achse
    float angle = Time*0.0003; // Rotation über Zeit
    mat4 rotationY = mat4(
        cos(angle), 0.0,  sin(angle), 0.0,
        0.0,        1.0,  0.0,        0.0,
       -sin(angle), 0.0,  cos(angle), 0.0,
        0.0,        0.0,  0.0,        1.0
    );*/

    vec4 t = vec4(vertexPosition, 1.0);
    t = Rotation * t;

    gl_Position = projectionMatrix * viewMatrix * modelMatrix * t;
    vs_vPos = t;
}
