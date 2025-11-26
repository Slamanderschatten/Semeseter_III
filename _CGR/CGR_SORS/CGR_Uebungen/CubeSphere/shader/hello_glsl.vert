uniform mat4 projectionMatrix;
uniform mat4 modelMatrix;
uniform mat4 viewMatrix;

uniform float Time;

layout (location = 0) in vec4 vertexPosition;
out vec4 vs_vPos;

void main()
{
    float radius = 2.0;

    vec3 center = vec3(0.0);

    vec3 dir = vertexPosition.xyz - center;

    if (length(dir) > 0.0001)
        dir = normalize(dir);

    vec3 spherePos = center + dir * radius;

    vec3 finalPos = mix(vertexPosition.xyz, spherePos, Time);

    gl_Position = projectionMatrix * viewMatrix * modelMatrix * vec4(finalPos, 1.0);

    vs_vPos = vec4(finalPos, 1.0);
}
