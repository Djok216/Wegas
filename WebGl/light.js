function Light(gl) {
	this.ambientColor = [];
	this.diffuseColor = [];
	this.direction = [];

	this.setAmbientColor =  function(r, g, b) {
		this.ambientColor = [];
		this.ambientColor.push(r, g, b);
	}
	this.getAmbientColor = function() {
		return this.ambientColor();
	}

	this.setDiffuseColor = function(r, g, b) {
		this.diffuseColor = [];
		this.diffuseColor.push(r, g, b);
	}
	this.getDiffuseColor = function() {
		return this.diffuseColor();
	}
	
	this.setDirection = function(x, y, z) {
		this.direction = [];
		this.direction.push(x, y, z);
	}
	this.getDirection = function() {
		return this.direction;
	}

	this.setActive = function(shader) {
		gl.uniform3f(shader.getAmbientColorUniformLocation(), this.ambientColor[0], this.ambientColor[1], this.ambientColor[2]);
		gl.uniform3f(shader.getDiffuseColorUniformLocation(), this.diffuseColor[0], this.diffuseColor[1], this.diffuseColor[2]);
		gl.uniform3f(shader.getLightDirectionUniformLocation(), this.direction[0], this.direction[1], this.direction[2]);
	}
}