uniform bool hastextureMap=false;
uniform sampler2D textureMap;
uniform float Time=1;

smooth in vec2 texCoords;
out vec4 fragColor;

void main()
{
    if(hastextureMap && texCoords.x != 0 && texCoords.x != tsize.x && texCoords.y != 0 && texCoords.y != tsize.y)
    {
        ivec2 tsize = textureSize(textureMap, 0);
        float stepX = 1.0/tsize.x;
        float stepY = 1.0/tsize.y;

        vec2 uv = vec2(10.0, 5.0) * texelSize;
        vec4 texel = texture(textureMap, uv);

        mat3 filt = mat3(
            1.0, 2.0, 1.0,
            2.0, 4.0, 2.0,
            1.0, 2.0, 1.0
        );
        mat3 text = mat3(
            textureMap
        );

        float s = 0.0;
        for (int r = 0; r < 3; r++)
        {
            for (int c = 0; c < 3; c++)
            {
                s += filt[r][c] * texture(textureMap, vec2());
            }
        }

        fragColor =
        
        fragColor = mix(texture(textureMap, texCoords), vec4(color,1.0), Time);
    }
    else
        fragColor = vec4(Time,Time,1.0,1.0);

}
