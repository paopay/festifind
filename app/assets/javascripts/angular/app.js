
(function(){
	var festival = angular.module('app', []);

	festival.controller('LoginController',['$http','$scope',function($http,$scope){
  	
	var userIsAuthenticated = true;
	this.login = {}
	$scope.formData = {};
	$scope.processForm = function(){
	console.log("dude")
	$http.post('/users/create', $scope.formData)
		.success(function(data) {
	});
	};
	}]);




























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
