#version 100

precision mediump float;

varying vec3 fragNormal;
varying vec3 fragPosition;

void main()
{
	vec3 modelColor = vec3(1.0, 0.0, 0.0);
	vec3 ambientColor = vec3(0.2, 0.2, 0.2);
	vec3 diffuseColor = vec3(0.9, 0.9, 0.9);
	vec3 direction = vec3(0.1, -0.5, 1.0);

	// Diffuse component
	float diffValue = max(dot(fragNormal, direction), 0.0);
	vec3 diffuse = diffValue * diffuseColor;

	gl_FragColor = vec4((ambientColor + diffuse) * modelColor, 1.0);
}