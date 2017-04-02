function Light() {
	this.ambientColor = [];
	this.diffuseColor = [];
	this.direction = [];

	this.setAmbientColor =  function(r, g, b, a) {
		this.ambientColor = [];
		this.ambientColor.push(r, g, b, a);
	}
	this.getAmbientColor = function() {
		return this.ambientColor();
	}

	this.setDiffuseColor = function(r, g, b, a) {
		this.diffuseColor = [];
		this.diffuseColor.push(r, g, b, a);
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
}