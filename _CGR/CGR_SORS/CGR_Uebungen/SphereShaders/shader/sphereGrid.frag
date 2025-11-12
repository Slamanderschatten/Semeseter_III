out vec4 fragColor;
in vec4 vs_vPos;

void main()
{
    if (mod(vs_vPos.x*10, 2.0) < 1.0 &&
        mod(vs_vPos.y*10, 2.0) < 1.0)
    {
        fragColor = vec4(1.0, 0.0, 0.0, 1.0); // rot
    }
    else
    {
        fragColor = vec4(0.0, 0.0, 0.0, 1.0); // Schwarz
    }
}
