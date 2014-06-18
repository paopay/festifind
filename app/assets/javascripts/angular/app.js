(function(){var festival= angular.module('app', []);
festival.controller('FestivalController',['$http',function($http){
this.artist = gem;

$http.get('/festivals/20').success(function(data){
	console.log(data);
})




}]);
})();

var gem = {name: 'Dodecahedron',price: 2.95,description: 'cool cool'}