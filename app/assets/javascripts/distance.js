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