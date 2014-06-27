
// (function(){
// 	var festival = angular.module('app', []);

// 	festival.controller('FestivalController',['$http',function($http){

// 	var festival = this
// 	festival.artists = []

// 	$http.get('/festivals/angular').success(function(data){	
// 		festival.artists = data.result;
// 	});
// 	this.favoriting = function(artist){
// 		if (artist.favorite == false) {
// 			artist.favorite = true;

// 		} else {
// 			artist.favorite = false;
// 		}
// 	};
// 	}]);
// })();



(function(){
	var myApp = angular.module('app',[]);
	myApp.controller('FestivalController',['$http',function($http){
		 all_festivals = this
		 all_festivals.festivals = []
		$http.get('/festivals/angular_festivals').success(function(data){
			all_festivals.festivals = data
			console.log(all_festivals.festivals)
		});



	}]);
})();

