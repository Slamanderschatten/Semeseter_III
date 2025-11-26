uniform mat4 projectionMatrix;
uniform mat4 modelMatrix;
uniform mat4 viewMatrix;

uniform float Time;

layout (location = 0) in vec4 vertexPosition;
out vec4 vs_vPos;

void main()
{
    float radius = 2.0;

    // Mittelpunkt der Kugel im Model Space
    vec3 center = vec3(0.0);

    // Richtung vom Mittelpunkt zum Vertex
    vec3 dir = vertexPosition.xyz - center;

    // Falls der Vertex genau im Mittelpunkt liegt: Sonderfall vermeiden
    if (length(dir) > 0.0001)
        dir = normalize(dir);

    // Position des Vertex auf der Kugeloberfläche
    vec3 spherePos = center + dir * radius;

    // Interpolation: 0 = original Mesh, 1 = Kugel
    vec3 finalPos = mix(vertexPosition.xyz, spherePos, Time);

    // Weiter in Clip Space transformieren
    gl_Position = projectionMatrix * viewMatrix * modelMatrix * vec4(finalPos, 1.0);

    vs_vPos = vec4(finalPos, 1.0);
}
