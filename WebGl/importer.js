function Importer(data) {
	this.data = data;
	this.verticesRaw = [];
	this.normalsRaw = [];
	this.vertices = [];
	this.faces = [];
	this.numVertices = 0;

	this.beginImport = function() {
		// !do not touch this line!!!!!!
		var tokens = data.replace(/(\r\n|\n|\r)/gm,' ').replace(/( )+/gm,' ').split(' '); //fucking fuck fuck
		
		for(i = 0; i< tokens.length; i++) {
			if(tokens[i]=='v') {
				this.verticesRaw.push(parseFloat(tokens[i+1]));
				this.verticesRaw.push(parseFloat(tokens[i+2]));
				this.verticesRaw.push(parseFloat(tokens[i+3]));
				i+=3;
			}
			else if(tokens[i] == 'vn'){
				this.normalsRaw.push(parseFloat(tokens[i+1]));
				this.normalsRaw.push(parseFloat(tokens[i+2]));
				this.normalsRaw.push(parseFloat(tokens[i+3]));
				i+=3;
			}
			else if(tokens[i]=='f') {
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