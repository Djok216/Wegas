function Importer(data) {
	this.data = data;
	this.verticesRaw = [];
	this.normalsRaw = [];
	this.textureRaw = [];
	this.vertices = [];
	this.faces = [];
	this.numVertices = 0;

	this.beginImport = function() {
		//console.error('mi-a intrat o pizda-n pula');
		// !do not touch this line!!!!!!
		var tokens = data.replace(/(\r\n|\n|\r)/gm,' ').replace(/( )+/gm,' ').split(' '); //fucking fuck fuck
		
		for(i = 0; i< tokens.length; i++) {
			if(tokens[i]=='v') { // Vertex position
				this.verticesRaw.push(parseFloat(tokens[i+1]));
				this.verticesRaw.push(parseFloat(tokens[i+2]));
				this.verticesRaw.push(parseFloat(tokens[i+3]));

				i+=3;
			}
			else if(tokens[i] == 'vn'){ // Vertex normal
				this.normalsRaw.push(parseFloat(tokens[i+1]));
				this.normalsRaw.push(parseFloat(tokens[i+2]));
				this.normalsRaw.push(parseFloat(tokens[i+3]));
				i+=3;
			}
			else if(tokens[i] == 'vt'){ // Vertex texture coordinates
				this.textureRaw.push(parseFloat(tokens[i+1]));
				this.textureRaw.push(parseFloat(1.0 - tokens[i+2]));
				this.textureRaw.push(parseFloat(tokens[i+3]));
				i+=3;
			}
			else if(tokens[i]=='f') { // Triangles
				this.faces.push(tokens[i+1]);
				this.faces.push(tokens[i+2]);
				this.faces.push(tokens[i+3]);
				i+=3;
			}
		}
		for(i = 0; i < this.faces.length; i++) {
			var faceSplited = this.faces[i].split('/');
			var index = parseInt(faceSplited[0])-1;
			this.vertices.push(this.verticesRaw[index*3]);
			this.vertices.push(this.verticesRaw[index*3+1]);
			this.vertices.push(this.verticesRaw[index*3+2]);

			var texCoordIndex = parseInt(faceSplited[1])-1;
			this.vertices.push(this.textureRaw[texCoordIndex*3]);
			this.vertices.push(this.textureRaw[texCoordIndex*3+1]);
			//this.vertices.push(this.textureRaw[texCoordIndex*3+2]);

			var normalIndex = parseInt(faceSplited[2])-1;
			this.vertices.push(this.normalsRaw[normalIndex*3]);
			this.vertices.push(this.normalsRaw[normalIndex*3+1]);
			this.vertices.push(this.normalsRaw[normalIndex*3+2]);

			this.numVertices++;
		}
	}

	this.getVertices = function() {
		return this.vertices;
	}

	this.getNumVertices = function(){
		return this.numVertices;
	}
}