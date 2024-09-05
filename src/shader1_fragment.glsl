#version 300 es
precision highp float;

uniform float time;
uniform vec2 resolution;

in VertexData
{
    vec4 v_position;
    vec3 v_normal;
    vec2 v_texcoord;
} inData;

out vec4 color;

#define PI 3.14159

void main()
{
    vec2 uv = inData.v_position.xy;
    
    float r = length(uv);
    float theta = atan(uv.y/uv.x);
    if(uv.x<0.)
    {
        theta += PI;
    }
    theta += r*5.;
    theta -= time*10.;
    uv = r*vec2(cos(theta),sin(theta));
    
    
    color = vec4(uv,0.,1.);
    
    float l = length(uv-vec2(0.5));
    color += vec4(l/2.0);
    
}
