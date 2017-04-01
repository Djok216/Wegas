#version 100

precision mediump float;

varying vec3 fragNormal;

void main()
{
	gl_FragColor = vec4(fragNormal, 1.0);
}