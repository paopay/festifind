
(function(){
	var festival = angular.module('app', []);

	festival.controller('FestivalController',['$http',function($http){

	var festival = this
	festival.artists = []

	$http.get('/festivals/angular').success(function(data){	
		festival.artists = data.result;
	});
	this.favoriting = function(artist){
		if (artist.favorite == false) {
			artist.favorite = true;

		} else {
			artist.favorite = false;
		}
	};
	}]);





})();
