function InitWebGl() {
	console.log('InitWebGl started...');
	var canvas = document.getElementById('renderSurface');
	var gl = canvas.getContext('webgl');

	if(!gl) {
		gl = canvas.getContext('experimental-webgl');
	}

	var light = new Light(gl);
	light.setAmbientColor(0.2, 0.2, 0.2);
	light.setDiffuseColor(0.9, 0.9, 0.9);
	light.setDirection(0.1, -0.5, 0.5);

	// create model
	var teapot = new Model(gl);
	teapot.init(downloadManager.getData('models/teapot.obj'));

	var pawn = new Model(gl);
	pawn.init(downloadManager.getData('models/pawn.obj'));

	var king = new Model(gl);
	king.init(downloadManager.getData('models/king.obj'));

	var queen = new Model(gl);
	queen.init(downloadManager.getData('models/queen.obj'));

	var bishop = new Model(gl);
	bishop.init(downloadManager.getData('models/bishop.obj'));

	var knight = new Model(gl);
	knight.init(downloadManager.getData('models/knight.obj'));

	var rook = new Model(gl);
	rook.init(downloadManager.getData('models/rook.obj'));

	var box = new Model(gl);
	box.init(downloadManager.getData('models/box.obj'));
	
	// creating texture
	var texture = new Texture(gl);
	texture.init('piece-texture');
	texture.setActive();

	// creating shader
	var defaultShader = new Shader(gl);
	defaultShader.init(downloadManager.getData('VertexShader.glsl'), downloadManager.getData('FragmentShader.glsl'));
	defaultShader.activate();

	var projMatrix = new Float32Array(16);
	
	var camera = new Camera(gl);
	camera.init();
	
	canvas.addEventListener('mousemove', function(evt) {
        camera.setMousePos(canvas, evt);
      }, false);

	canvas.addEventListener('mousedown', function(evt) {
        camera.toggleMouseUpdate(true);
      }, false);

	canvas.addEventListener('mouseup', function(evt) {
        camera.toggleMouseUpdate(false);
      }, false);
	canvas.addEventListener('mouseout', function(evt) {
        camera.toggleMouseUpdate(false);
      }, false);

	mat4.perspective(projMatrix, glMatrix.toRadian(45), canvas.width/canvas.height, 0.1, 100.0);

	gl.uniformMatrix4fv(defaultShader.getMatProjectionUniformLocation(), gl.FALSE, projMatrix);

	teapot.setPosition(6, 0, 0);
	pawn.setPosition(4.5, 0, 0);
	king.setPosition(3, 0, 0);
	queen.setPosition(1.5, 0, 0);
	bishop.setPosition(0, 0, 0);
	knight.setPosition(-1.5, 0, 0);
	rook.setPosition(-3, 0, 0);
	box.setPosition(-5, 0, 0);

	//main render loop
	gl.enable(gl.DEPTH_TEST);

	light.setActive(defaultShader);

	var loop = function() {
		gl.clearColor(0.9, 0.9, 0.9, 1.0);
		gl.clear(gl.DEPTH_BUFFER_BIT | gl.COLOR_BUFFER_BIT);

		camera.handleInput();
		camera.updateMatrix(defaultShader);

		teapot.render(defaultShader);
		pawn.render(defaultShader);
		king.render(defaultShader);
		queen.render(defaultShader);
		bishop.render(defaultShader);
		knight.render(defaultShader);
		rook.render(defaultShader);
		box.render(defaultShader);
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
	downloadManager.addResourceToQueue("models/pawn.obj");
	downloadManager.addResourceToQueue("models/king.obj");
	downloadManager.addResourceToQueue("models/queen.obj");
	downloadManager.addResourceToQueue("models/bishop.obj");
	downloadManager.addResourceToQueue("models/knight.obj");
	downloadManager.addResourceToQueue("models/rook.obj");
	downloadManager.addResourceToQueue("models/teapot.obj");
	downloadManager.addResourceToQueue("models/box.obj");
	downloadManager.beginDownload(InitWebGl);
};