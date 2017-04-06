function Camera(gl) {
	this.position = [];
	this.lookAt = [];
	this.up = [];
	this.prevMouseCoordinates = [];
	this.mouseCoordinates = [];
	this.relativeMouseCoordinates = [];

	this.init = function() {
		viewMatrix = new Float32Array(16);
		this.position = [0,2,10];
		this.lookAt = [0,0,0];
		this.up = [0,1,0];
		radius = 10.0;

		this.prevMouseCoordinates = [0, 0];
		this.mouseCoordinates = [0, 0];
		this.relativeMouseCoordinates = [0, 0];
		mouseUpdate = false;
	}

	this.setMousePos = function(canvas, evt) {
		var rect = canvas.getBoundingClientRect();
		this.prevMouseCoordinates = this.mouseCoordinates;
		this.mouseCoordinates = [evt.clientX - rect.left, evt.clientY - rect.top];
		this.relativeMouseCoordinates[0] = this.mouseCoordinates[0] - this.prevMouseCoordinates[0];
		this.relativeMouseCoordinates[1] = this.mouseCoordinates[1] - this.prevMouseCoordinates[1];
	}

	this.toggleMouseUpdate = function(toggle) {
		mouseUpdate = toggle;
		if(toggle == false){
			this.relativeMouseCoordinates = [0, 0];
		}
	}

	this.getViewMatrix = function() {
		return viewMatrix;	
	}

	this.updateMatrix = function(shader) {
		mat4.lookAt(viewMatrix,this.position,this.lookAt,this.up); // camera position, lookAt, up
		gl.uniformMatrix4fv(shader.getMatViewUniformLocation(), gl.FALSE, viewMatrix);
	}

	this.handleInput = function() {
		// Calculate relative x and y mouse coordinates
		if(mouseUpdate == true){
			angle += 0.01 * -this.relativeMouseCoordinates[0];
			this.position[1] += 0.1 * this.relativeMouseCoordinates[1];
			if(this.position[1] > 17.5)
				this.position[1] = 17.5;
			else if(this.position[1] < 3.0)
				this.position[1] = 3.0;
			this.relativeMouseCoordinates = [0, 0];
		}
		sin = Math.sin(angle * Math.PI);
		cos = Math.cos(angle * Math.PI);
		if(sin == 0.0)
			sin = 0.0001;
		if(cos == 0.0)
			cos = 0.0001;
		this.position[0] = radius * sin;
		this.position[2] = radius * cos;
	}
}