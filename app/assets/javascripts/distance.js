//Example festival array
festivals_array = []

var festival1 = {lat:38.7822554, lng:-122.391244} 
var festival2 = {lat:36.45, lng:-122.43}
var festival5 = {lat:45.45, lng:-142.43}
var festival3 = {lat:39.45, lng:-102.43}
var festival4 = {lat:49.45, lng:-62.43}
 
festivals_array.push(festival4)
festivals_array.push(festival1)
festivals_array.push(festival3)
festivals_array.push(festival2)
festivals_array.push(festival5)

//Get distance from user to festival
var rad = function(x) {
  return x * Math.PI / 180;
};

var getDistance = function(user, festival) {
  var R = 6378137; // Earth’s mean radius in meter
  var dLat = rad(festival.lat - user.lat);
  var dLong = rad(festival.lng - user.lng);
  var a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
    Math.cos(rad(user.lat)) * Math.cos(rad(festival.lat)) *
    Math.sin(dLong / 2) * Math.sin(dLong / 2);
  var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
  var d = R * c;
  return d*0.000621371; // returns the distance in miles
};

user = {}
navigator.geolocation.getCurrentPosition(function(position){user.lat = position.coords.latitude, user.lng = position.coords.longitude})
festival

festivals_array.sort(function(a,b){return getDistance(user,a)-getDistance(user,b)}
