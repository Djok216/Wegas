#version 100

precision mediump float;

attribute vec3 position;
attribute vec2 texCoord;
attribute vec3 normal;

varying vec2 fragTexCoord;
varying vec3 fragNormal;
varying vec3 fragAmbientColor;
varying vec3 fragDiffuseColor;
varying vec3 fragLightDirection;

uniform mat4 matrixWorld;
uniform mat4 matrixView;
uniform mat4 matrixProjection;
uniform vec3 ambientColor;
uniform vec3 diffuseColor;
uniform vec3 lightDirection;

void main()
{
	fragTexCoord = texCoord;
	fragAmbientColor = ambientColor;
	fragDiffuseColor = diffuseColor;
	fragLightDirection = lightDirection;
	fragNormal = (matrixWorld * vec4(normal, 0.0)).xyz;
	gl_Position = matrixProjection * matrixView * matrixWorld * vec4(position, 1.0);
}