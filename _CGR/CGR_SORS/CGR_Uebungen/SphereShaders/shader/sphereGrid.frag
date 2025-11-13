out vec4 fragColor;
in vec4 vs_vPos;

void main()
{

    float circleRadius = 4;
    float circleDistance = 12;


    vec2 pos = mod(gl_FragCoord.xy, vec2(circleDistance));

    if(length(pos) < circleRadius ||
        length(pos - circleDistance) < circleRadius ||
        length(pos - vec2(circleDistance, 0.0)) < circleRadius ||
        length(pos - vec2(0.0, circleDistance)) < circleRadius)
    {
        fragColor = vec4(1.0, 0.0, 0.0, 1.0); // rot
    }
    else
    {
        fragColor = vec4(0.0, 0.0, 0.0, 1.0); // Schwarz
    }
}
