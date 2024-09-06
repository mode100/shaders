#version 300 es
precision highp float;

uniform float time;
uniform vec2 resolution;

uniform sampler2D noise1;

in VertexData
{
    vec4 v_position;
    vec3 v_normal;
    vec2 v_texcoord;
} inData;

out vec4 color;

#define PI 3.14159

// 0~1をなめらかな0~1に変換
float mysmoothstep(float x)
{
    return smoothstep(0.,1.,x); // x*x*(3.-2.*x)
//    return -cos(PI*x)/2.+0.5;
//    return tanh((x-0.5)*5.)*0.5+0.5;
//    return x;
}

vec4 smoothedTexture(sampler2D tex,vec2 uv,float len)
{
    uv = fract(uv);
    float ratex = (fract(uv.x+0.5)-0.5+len/2.)/len;
    float ratey = (fract(uv.y+0.5)-0.5+len/2.)/len;
    
    float x1 = uv.x;
    float x2 = uv.x;
    float y1 = uv.y;
    float y2 = uv.y;
    float rate = 0.;
    if(0.5-abs(uv.x-0.5)<=len/2.)
    {
        x1 = 1.-len/2.;
        x2 = len/2.;
        rate = ratex;
    }
    if(0.5-abs(uv.y-0.5)<=len/2.)
    {
        y1 = 1.-len/2.;
        y2 = len/2.;
        rate = ratey;
    }
    
    if(0.5-abs(uv.x-0.5)<=len/2. && 0.5-abs(uv.y-0.5)<=len/2.)
    {
        vec4 col1 = texture(tex,vec2(x1,y1));
        vec4 col2 = texture(tex,vec2(x2,y1));
        vec4 mcol1 = mix(col1,col2,mysmoothstep(ratex));
        col1 = texture(tex,vec2(x1,y2));
        col2 = texture(tex,vec2(x2,y2));
        vec4 mcol2 = mix(col1,col2,mysmoothstep(ratex));
        return mix(mcol1,mcol2,mysmoothstep(ratey));
    }
    if(0.5-abs(uv.x-0.5)<=len/2. || 0.5-abs(uv.y-0.5)<=len/2.)
    {
        vec4 col1 = texture(tex,vec2(x1,y1));
        vec4 col2 = texture(tex,vec2(x2,y2));
        return mix(col1,col2,mysmoothstep(rate));
    }
    return texture(tex,uv);  
}

void main(void)
{
    vec2 uv = inData.v_position.xy;
    uv = uv + vec2(time/2.);
    color = smoothedTexture(noise1,uv,0.075);
}
