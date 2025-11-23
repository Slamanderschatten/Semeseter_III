uniform bool hastextureMap = false;
uniform sampler2D textureMap;
uniform mat3 Filter;     // 3×3 Kernel

smooth in vec2 texCoords;
out vec4 fragColor;

void main()
{
    if (hastextureMap)
    {
        ivec2 tsize = textureSize(textureMap, 0);
        vec2 texel = 1.0 / vec2(tsize);

        float weightSum = 0.0;
        vec4 blur = vec4(0.0);

        for (int y = -1; y <= 1; y++)
        {
            for (int x = -1; x <= 1; x++)
            {
                vec2 offset = vec2(x, y) * texel;
                float w = Filter[y+1][x+1];

                blur += texture(textureMap, texCoords + offset) * w;
                weightSum += w;
            }
        }

        fragColor = blur / weightSum;
    }
}