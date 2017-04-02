function DownloadManager() {
	this.resources = [];

	this.addResourceToQueue = function(url) {
		this.resources.push(url);
	}

	this.beginDownload = function(callbackFunction) {
		var resourcesDownloaded = 0;
		var totalResources = this.resources.length;

		data = {};
		console.log('Resource download started...');
		for(i = 0; i < totalResources; i++) {
			getFileFromServer(this.resources[i], function(text, url) {
				if(text === null) {
					console.error('Error reading from '.concat(this.resources[i]).concat(' file.'));
				}
				else {
					data[url] = text;
					resourcesDownloaded++;
					if(resourcesDownloaded == totalResources){
						console.log('All resources are downloaded!');
						callbackFunction();
					}
				}
			});
		}
	}

	this.getData = function(resourceName) {
		return data[resourceName];
	}

	function getFileFromServer(url, doneCallback)
	{
		var xhr;
		xhr = new XMLHttpRequest();
		xhr.onreadystatechange = handleStateChange;
		xhr.open('GET', url, true);
		// to be removed at the deployment! :)
		xhr.setRequestHeader('Cache-Control', 'no-cache, must-revalidate');
		xhr.send();
		function handleStateChange() {
			if(xhr.readyState === 4) {
				doneCallback(xhr.status == 200 ? xhr.responseText : null, url);
			}
		}
	}
}