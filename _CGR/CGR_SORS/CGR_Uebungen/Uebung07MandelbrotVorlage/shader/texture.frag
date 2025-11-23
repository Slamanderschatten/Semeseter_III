#version 330 core

uniform vec2 Center = vec2(0.0, 0.0);
uniform float Zoom = 1.0;
uniform float MaxIterations = 10.0;
uniform bool RenderWithShader = true;

uniform vec3 InnerColor = vec3(1.0, 0.0, 0.0);
uniform vec3 OuterColor1 = vec3(0.0, 1.0, 0.0);
uniform vec3 OuterColor2 = vec3(0.0, 0.0, 1.0);

in vec2 texCoords; // UV-Koordinaten
out vec4 fragColor;

void main()
{
    if (!RenderWithShader)
    {
        fragColor = vec4(InnerColor, 1.0);
        return;
    }

    float x0 = (texCoords.x - 0.5) * Zoom + Center.x;
    float y0 = (texCoords.y - 0.5) * Zoom + Center.y;

    float x = x0;
    float y = y0;
    float iteration = 0.0;

    float x2 = 0.0;
    float y2 = 0.0;

    for (iteration = 0.0; iteration < MaxIterations && (x2 + y2) < 4.0; iteration += 1.0)
    {
        float xtemp = x2 - y2 + x0;
        y = 2.0 * x * y + y0;
        x = xtemp;

        x2 = x * x;
        y2 = y * y;
    }

    vec3 color;
    if (x2 + y2 < 4.0)
        color = InnerColor;
    else
    {
        float t = fract(iteration * 0.05);
        color = mix(OuterColor1, OuterColor2, t);
    }

    fragColor = vec4(color, 1.0);
}