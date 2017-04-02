function Shader(gl) {

	this.init = function(vertexShaderData, fragmentShaderData) {
		// create shader
		var vertexShader = gl.createShader(gl.VERTEX_SHADER);
		var fragmentShader = gl.createShader(gl.FRAGMENT_SHADER);

		// set shader data
		gl.shaderSource(vertexShader, vertexShaderData);
		gl.shaderSource(fragmentShader, fragmentShaderData);

		// compile
		gl.compileShader(vertexShader);
		gl.compileShader(fragmentShader);

		// check error shaders
		if(!gl.getShaderParameter(vertexShader, gl.COMPILE_STATUS)) {
			console.error('Error compiling the vertex shader!', gl.getShaderInfoLog(vertexShader));
			return;
		}

		if(!gl.getShaderParameter(fragmentShader, gl.COMPILE_STATUS)) {
			console.error('Error compiling the fragment shader!', gl.getShaderInfoLog(fragmentShader));
			return;
		}

		// create program to combine the shaders
		program = gl.createProgram();
		gl.attachShader(program, vertexShader);
		gl.attachShader(program, fragmentShader);

		gl.linkProgram(program);

		if(!gl.getProgramParameter(program, gl.LINK_STATUS)) {
			console.error('Error linking shaders!', gl.getProgramInfoLog(program));
			return;
		}
		// something strange here
		gl.validateProgram(program);
		if(!gl.getProgramParameter(program, gl.VALIDATE_STATUS)) {
			console.error('Error validating program!', gl.getProgramInfoLog(program));
			return;
		}
		setShaderFormat();

		matWorldUniformLocation = gl.getUniformLocation(program, 'matrixWorld');
		matViewUniformLocation = gl.getUniformLocation(program, 'matrixView');
		matProjectionUniformLocation = gl.getUniformLocation(program, 'matrixProjection');
	}

	this.activate = function() {
		gl.enableVertexAttribArray(positionAttributeLocation);
		gl.enableVertexAttribArray(normalAttributeLocation);

		gl.useProgram(program);
	}

	this.getMatWorldUniformLocation = function() {
		return matWorldUniformLocation;
	}
	this.getMatViewUniformLocation = function() {
		return matViewUniformLocation;
	}
	this.getMatProjectionUniformLocation = function() {
		return matProjectionUniformLocation;
	}

	function setShaderFormat() {
		// format definition
		positionAttributeLocation = gl.getAttribLocation((program), 'position');
		normalAttributeLocation = gl.getAttribLocation((program), 'normal');

		gl.vertexAttribPointer(
			positionAttributeLocation, // attribute location
			3, // number of elements per atributes,
			gl.FLOAT, // type of elements
			gl.FALSE,
			6 * Float32Array.BYTES_PER_ELEMENT, // size of an individual vertex
			0 // offset from the beggining of single vertex
		);
		gl.vertexAttribPointer(
			normalAttributeLocation, // attribute location
			3, // number of elements per atributes,
			gl.FLOAT, // type of elements
			gl.TRUE,
			6 * Float32Array.BYTES_PER_ELEMENT, // size of an individual vertex
			3 * Float32Array.BYTES_PER_ELEMENT // offset from the beggining of single vertex
		);
	}
}