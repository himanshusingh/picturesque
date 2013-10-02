$(document).ready(function() {
	$('body').prepend('<div id="fb-root"></div>');
	window.fbAsyncInit = function() {
	  	FB.init({
	  	  appId      : '526129834133050', // App ID
	  	  channelUrl : '//localhost:3333/channel.html', // Channel File
	  	  status     : true, // check login status
	  	  cookie     : true, // enable cookies to allow the server to access the session
	  	  xfbml      : true  // parse XFBML
	  	});

	  	FB.Event.subscribe('auth.statusChange', function (response) {
	  	      $(document).trigger('fbStatusChange', response);
	  	  });

	  	app.isLoggedIn = true
	};

	// Load the SDK asynchronously
	(function(d){
	 var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
	 if (d.getElementById(id)) {return;}
	 js = d.createElement('script'); js.id = id; js.async = true;
	 js.src = "//connect.facebook.net/en_US/all.js";
	 ref.parentNode.insertBefore(js, ref);
	}(document));

});