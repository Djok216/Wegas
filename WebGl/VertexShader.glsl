#version 100

precision mediump float;

attribute vec3 position;
attribute vec3 normal;

varying vec3 fragNormal;

uniform mat4 matrixWorld;
uniform mat4 matrixView;
uniform mat4 matrixProjection;

void main()
{
	fragNormal = (matrixWorld * vec4(normal, 0.0)).xyz;
	gl_Position = matrixProjection * matrixView * matrixWorld * vec4(position, 1.0);
}