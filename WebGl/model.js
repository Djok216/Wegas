function Model(gl) {
	this.position = vec3.create();
	this.importer;
	this.vertexBuffer;

	this.init = function(data) {
		this.importer = new Importer(data);
		this.importer.beginImport();

		this.vertexBuffer = gl.createBuffer();
		gl.bindBuffer(gl.ARRAY_BUFFER, this.vertexBuffer);
		gl.bufferData(gl.ARRAY_BUFFER, new Float32Array(this.importer.getVertices()), gl.STATIC_DRAW);

		worldMatrix = new Float32Array(16);
		mat4.identity(worldMatrix);

		rotationMatrix = new Float32Array(16);
		mat4.identity(rotationMatrix);
		angle = 0;
		vec3.set(this.position, 0, 0, 0);
	}

	this.getWorldMatrix = function() {
		return worldMatrix;
	}

	this.render = function(shader) {
		angle += 0.01;

		gl.bindBuffer(gl.ARRAY_BUFFER, this.vertexBuffer);
		gl.bufferData(gl.ARRAY_BUFFER, new Float32Array(this.importer.getVertices()), gl.STATIC_DRAW);
		shader.activate();

		mat4.identity(worldMatrix);
		mat4.translate(worldMatrix, worldMatrix, this.position);
		mat4.rotate(worldMatrix, worldMatrix, angle, [0,1,0]);

		gl.uniformMatrix4fv(shader.getMatWorldUniformLocation(), gl.FALSE, worldMatrix);
		gl.drawArrays(gl.TRIANGLES, 0, this.importer.getNumVertices()); // OFFSET + NR OF VERTICES
	}

	this.setPosition = function(x, y, z) {
		vec3.set(this.position, x, y, z);
	}
}