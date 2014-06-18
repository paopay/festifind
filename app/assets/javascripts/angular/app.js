// festivalName =$('.explore').html()
(function(){
	var festival = angular.module('app', []);
festival.controller('FestivalController',['$http',function($http){
// this.artist = gem;
// var go = []
var festival = this
festival.artists = []
$http.get('/festivals/angular').success(function(data){
	
	festival.artists = data.result;
})



}]);
})();
