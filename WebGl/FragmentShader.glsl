#version 100

precision mediump float;

uniform sampler2D sampler;

varying vec2 fragTexCoord;
varying vec3 fragNormal;
varying vec3 fragAmbientColor;
varying vec3 fragDiffuseColor;
varying vec3 fragLightDirection;


void main()
{
	vec4 textureColor = texture2D(sampler, fragTexCoord);

	// Diffuse component
	float diffValue = max(dot(fragNormal, fragLightDirection), 0.0);
	vec3 diffuse = diffValue * fragDiffuseColor;

	gl_FragColor = vec4((fragAmbientColor + diffuse) * textureColor.xyz, 1.0);
}