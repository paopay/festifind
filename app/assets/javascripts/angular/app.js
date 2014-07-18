
(function(){
	var festival = angular.module('app', []);

	festival.controller('LoginController',['$http','$scope',function($http,$scope){
  	
	$scope.userIsAuthenticated = false;
	$scope.showLogin = false;
	$scope.add = false;
	$scope.showForm =function(){
		$('.lightbox_form').css('display','block')
	}
	this.login = {}

	$scope.formData = {};
	$scope.firstName = {};
	$scope.showLoginForm = function(){
		console.log("hiiii")
		$('.login_form').css('display','block')
	};
	$scope.processForm = function(){
	$http.post('/users/create', $scope.formData)
		.success(function(data) {
			$scope.userIsAuthenticated = true;
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
