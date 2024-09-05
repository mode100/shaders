#version 300 es
//KodeLifeのデフォルトから要らない部分を消したもの。
//Just delete unneeded parts from KodeLife's default code.

uniform float time;
uniform vec2 resolution;
uniform vec2 mouse;

in vec4 a_position;
in vec3 a_normal;
in vec2 a_texcoord;

out VertexData
{
    vec4 v_position;
    vec3 v_normal;
    vec2 v_texcoord;
} outData;

void main()
{
    gl_Position = a_position;

    outData.v_position = a_position;
    outData.v_normal = a_normal;
    outData.v_texcoord = a_texcoord;
}
