#version 300 es
precision highp float;

uniform float time;
uniform vec2 resolution;

uniform sampler2D noise;

out vec4 color;

void main()
{
    vec2 uv0 = gl_FragCoord.xy/resolution;
    vec2 uv = uv0;
    uv = fract(uv+vec2(0.,-time*2.));
    color = texture(noise,uv)+vec4(-uv0.y);
    if(color.r >= 0.4)
    {
        color = vec4(1.);
    }
    else
    {
        color = vec4(vec3(0.),1.);
    }
    if(color.r == 1.)
    {
        uv = fract(uv+vec2(0.,-time*2.));
        color = texture(noise,uv)+vec4(-uv0.y);
        color = vec4(1.,color.r-0.2,0.,1.);
    }
}
