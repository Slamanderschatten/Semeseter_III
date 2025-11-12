out vec4 fragColor;
in vec4 vs_vPos;

void main()
{
	vec3 eins = vec3(0.0,0.0,1.0);
	vec3 zwei = vec3(0.0,0.0,0.0);
	vec3 drei = vec3(0.0,0.0,0.0);
	mat3 m = mat3(eins,zwei,drei); //major column order
        fragColor = vec4(m*vec3(1.0,0.0,0.0),1.0);
        fragColor = vec4(-256,1000,27,1);//vs_vPos;
}
