window.fbAsyncInit = function () {
  FB.init({
    appId: '432359763790011',
    xfbml: true,
    version: 'v2.9'
  });
  FB.AppEvents.logPageView();
};

(function (d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) {
    return;
  }
  js = d.createElement(s);
  js.id = id;
  js.src = "//connect.facebook.net/en_US/sdk.js";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));

function facebookLogin() {
  FB.login(function (response) {
    if (response.authResponse) {
      var access_token = response.authResponse.accessToken; //get access token
      var user_id = response.authResponse.userID; //get FB UID
      var name = response.name;
      FB.api('/me?fields=id,name,email,permissions', function (response) {
        var email = response.email;
        var name = response.name;
        console.log(user_id);
        console.log(email);
        console.log(name);
        return loginWithFacebook(user_id, email, name);
      });
    } else {
      console.log('User cancelled login or did not fully authorize.');
    }
  }, {scope: 'email', return_scopes: true});

}

function loginWithFacebook(facebookId, email, name) {
  var http = new XMLHttpRequest();

  var header = new Headers();
  header.append('Content-Type', 'application/json');

  var json = JSON.stringify({
    facebookId: facebookId,
    email: email,
    name: name
  });

  console.log(json);

  http.open("POST", 'http://localhost:4500/user/loginFB', true);
  http.setRequestHeader('Content-Type', 'application/json');

  http.onreadystatechange = function () {//Call a function when the state changes.
    if (http.readyState == 4 && http.status == 200) {
      console.log(http.responseText);
    }
  };

  http.send(json);

  return http.responseText;
}
