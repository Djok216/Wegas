var fragmentShaderData;
var vertexShaderData;
var cubeData;

function DownloadResources() {
	var resourcesDownloaded = 0;

	console.log('DownloadResources started...');
	getFileFromServer('VertexShader.glsl', function(text) {
		if(text === null) {
			console.error('Error reading from "VertexShader.glsl" file.');
		}
		else {
			this.vertexShaderData = text;
			resourcesDownloaded++;
			if(resourcesDownloaded == 3)
				InitWebGl();
		}
	});
	getFileFromServer('FragmentShader.glsl', function(text) {
		if(text === null) {
			console.error('Error reading from "FragmentShader.glsl" file.');
		}
		else {
			this.fragmentShaderData= text;
			resourcesDownloaded++;
			if(resourcesDownloaded == 3)
				InitWebGl();
		}
	});
	getFileFromServer('teapot.obj', function(text) {
		if(text === null) {
			console.error('Error reading from "teapot.obj" file.');
		}
		else {
			this.cubeData = text;
			resourcesDownloaded++;
			if(resourcesDownloaded == 3)
				InitWebGl();
		}
	});
}

function InitWebGl() {
	var importer = new Importer(cubeData);
	importer.beginImport();

	console.log('InitWebGl started...');
	var canvas = document.getElementById('renderSurface');
	var gl = canvas.getContext('webgl');

	if(!gl) {
		gl = canvas.getContext('experimental-webgl');
	}

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
	var program = gl.createProgram();
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

	var vertexBuffer = gl.createBuffer();
	gl.bindBuffer(gl.ARRAY_BUFFER, vertexBuffer);
	gl.bufferData(gl.ARRAY_BUFFER, new Float32Array(importer.getVertices()), gl.STATIC_DRAW);

	// format definition
	var positionAttributeLocation = gl.getAttribLocation(program, 'position');
	var normalAttributeLocation = gl.getAttribLocation(program, 'normal');

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

	gl.enableVertexAttribArray(positionAttributeLocation);
	gl.enableVertexAttribArray(normalAttributeLocation);

	var matWorldUniformLocation = gl.getUniformLocation(program, 'matrixWorld');
	var matViewUniformLocation = gl.getUniformLocation(program, 'matrixView');
	var matProjectionUniformLocation = gl.getUniformLocation(program, 'matrixProjection');

	var projMatrix = new Float32Array(16);
	var viewMatrix = new Float32Array(16);
	var worldMatrix = new Float32Array(16);

	mat4.identity(worldMatrix);
	mat4.lookAt(viewMatrix,[0,0,-5],[0.0,0,0],[0,1,0]); // camera position, lookAt, up
	mat4.perspective(projMatrix,glMatrix.toRadian(45), canvas.width/canvas.height, 0.1, 100.0);

	gl.useProgram(program);

	gl.uniformMatrix4fv(matWorldUniformLocation, gl.FALSE, worldMatrix);
	gl.uniformMatrix4fv(matViewUniformLocation, gl.FALSE, viewMatrix);
	gl.uniformMatrix4fv(matProjectionUniformLocation, gl.FALSE, projMatrix);

	//main render loop
	gl.enable(gl.DEPTH_TEST);
	var rotationMatrix = new Float32Array(16);
	mat4.identity(rotationMatrix);
	var angle = 0;
	var loop = function() {
		angle += 0.01;
		mat4.rotate(worldMatrix, rotationMatrix, angle, [0,1,0]);
		gl.uniformMatrix4fv(matWorldUniformLocation, gl.FALSE, worldMatrix);
		gl.clearColor(0.9, 0.9, 0.9, 1.0);
		gl.clear(gl.DEPTH_BUFFER_BIT | gl.COLOR_BUFFER_BIT);
		gl.drawArrays(gl.TRIANGLES, 0, importer.getNumVertices()); // OFFSET + NR OF VERTICES
		requestAnimationFrame(loop);
	}
	requestAnimationFrame(loop);
}

function Run() {

}

function OnLoad() {
	DownloadResources();
};

function getFileFromServer(url, doneCallback)
{
	var xhr;
	xhr = new XMLHttpRequest();
	xhr.onreadystatechange = handleStateChange;
	xhr.open("GET", url, true);
	xhr.send();	function handleStateChange() {
		if(xhr.readyState === 4) {
			doneCallback(xhr.status == 200 ? xhr.responseText : null);
		}
	}
}