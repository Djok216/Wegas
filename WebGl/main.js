function InitWebGl() {
	console.log('InitWebGl started...');
	var canvas = document.getElementById('renderSurface');
	var gl = canvas.getContext('webgl');

	if(!gl) {
		gl = canvas.getContext('experimental-webgl');
	}
	
	// create model
	var teapotModel = new Model(gl);
	teapotModel.init(downloadManager.getData('teapot.obj'));

	var teapotModel2 = new Model(gl);
	teapotModel2.init(downloadManager.getData('cube.obj'));

	// creating shader
	var defaultShader = new Shader(gl);
	defaultShader.init(downloadManager.getData('VertexShader.glsl'), downloadManager.getData('FragmentShader.glsl'));
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
	downloadManager = new DownloadManager();
	downloadManager.addResourceToQueue("VertexShader.glsl");
	downloadManager.addResourceToQueue("FragmentShader.glsl");
	downloadManager.addResourceToQueue("cube.obj");
	downloadManager.addResourceToQueue("teapot.obj");
	downloadManager.beginDownload(InitWebGl);
};