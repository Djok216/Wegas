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
	console.log('InitWebGl started...');
	var canvas = document.getElementById('renderSurface');
	var gl = canvas.getContext('webgl');

	if(!gl) {
		gl = canvas.getContext('experimental-webgl');
	}
	
	// create model
	var teapotModel = new Model(gl);
	teapotModel.init(cubeData);

	var teapotModel2 = new Model(gl);
	teapotModel2.init(cubeData);

	// creating shader
	var defaultShader = new Shader(gl);
	defaultShader.init(vertexShaderData, fragmentShaderData);
	defaultShader.activate();

	var projMatrix = new Float32Array(16);
	var viewMatrix = new Float32Array(16);
	
	mat4.lookAt(viewMatrix,[0,0,5],[0.0,0,0],[0,1,0]); // camera position, lookAt, up
	mat4.perspective(projMatrix,glMatrix.toRadian(45), canvas.width/canvas.height, 0.1, 100.0);

	gl.uniformMatrix4fv(defaultShader.getMatViewUniformLocation(), gl.FALSE, viewMatrix);
	gl.uniformMatrix4fv(defaultShader.getMatProjectionUniformLocation(), gl.FALSE, projMatrix);


	teapotModel.setPosition(1.2,0,0);
	teapotModel2.setPosition(-0.3,0,0);
	//main render loop
	gl.enable(gl.DEPTH_TEST);
	var loop = function() {
		gl.clearColor(0.9, 0.9, 0.9, 1.0);
		gl.clear(gl.DEPTH_BUFFER_BIT | gl.COLOR_BUFFER_BIT);
		teapotModel.render(defaultShader);
		teapotModel2.render(defaultShader);
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
	xhr.open('GET', url, true);
	// to be removed at the deployment! :)
	xhr.setRequestHeader('Cache-Control', 'no-cache, must-revalidate');
	xhr.send();	function handleStateChange() {
		if(xhr.readyState === 4) {
			doneCallback(xhr.status == 200 ? xhr.responseText : null);
		}
	}
}