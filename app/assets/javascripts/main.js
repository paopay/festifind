var getArtists = (function(){
  return {
    finder: function(clickedFestival){
      $.ajax({
      url: '/artists/find',
      data: {festival:clickedFestival},
      type: 'GET'
    })
    .done(function(data){  
      artistsJSONObject = data.artists
      var source   = $("#some-template").html();
    var template = Handlebars.compile(source);
    var handleData = artistsJSONObject

    $(".artists_module").show();
    $("#content-placeholder").html(template(handleData));   
    })
    }
  }
})();

$(document).ready(function() {   
user = {}
navigator.geolocation.getCurrentPosition(function(position){user.lat = position.coords.latitude, user.lng = position.coords.longitude})
$(".festival-icon").load(function() {
  for(i=0; i < $(".festival-icon").length; i++){
    if($('.festival-icon')[i].naturalHeight === 298 && $('.festival-icon')[i].naturalWidth === 298){
      x = $('.image')[i]
      x.children[0].src="http://i.telegraph.co.uk/multimedia/archive/01386/festival1_1386566c.jpg"
    }
  }
})
projectModel = new ProjectModel
projectView = new ProjectView(projectModel)
projectController = new ProjectController(projectView,projectModel)
projectController.bindListeners()
  $("#grid").on("click", ".block", function(e) {
    if ($(this).find(".image").css("display") != "none") {
      $(this).flip({
        direction:'lr',
        speed: 300
      })

      $(this).find(".image").css("display", "none")
      $(this).find(".info").css("display", "table-cell")
    }
  })
})

var ProjectView = function(projectModel){
  this.projectModel = projectModel
}

ProjectView.prototype = {
  removeLink : function(e){
    console.log("hi")
    // $(e.currentTarget)[0].remove()

  },
  update: function(){
    console.log("WTFFF")
    $('.explore').hide();
    $('#show_favs').show()
    $('#each_festival').empty()
    for (x=0;x<this.projectModel.favoriteFestivals.length;x++) {
      $('#each_festival').append("<span class='festival_name'>"+this.projectModel.favoriteFestivals[x]+"</span><a class='favs greg' href='#' data-name='"+this.projectModel.favoriteFestivals[x]+"'> Build my lineup</a><br>")
    }
  }  
}
var projectModule = (function(){

})

var ProjectModel = function(){
  this.favoriteFestivals = []
  this.allFestivalArtists = []
}

ProjectModel.prototype = {
  addFestivalToModel : function(e){
    update = $(e.target)
    object = $(e.target).data('val')
    this.favoriteFestivals.push(object)
  },
  getArtistsFromDB : function(e){
    clickedHTML = $(e.target)[0]
    clickedFestival = clickedHTML.dataset.name
    
    getArtists.finder(clickedFestival)

  }
}


var ProjectController = function(projectView,projectModel){
  this.projectView = projectView
  this.projectModel = projectModel
}

ProjectController.prototype = {
  bindListeners : function(){
    $('.fav_text').on('click',this.addFestival.bind(this))
    $(document).on('click','.greg',this.getArtists.bind(this))
    $('.distance').on('click', this.sortFestbyDistance.bind(this))
    $('.popularity').on('click', this.sortFestbyPopularity.bind(this))
    $('.date').on('click', this.sortFestbyDate.bind(this))
    $('.random').on('click', this.sortFestbyRandom.bind(this))
    $('.my_favs').on('click', this.showFavs)
  },
  showFavs:function(e){
    $('#festivals_box').show();
  },
  replaceBadPhotos: function(){
    debugger
    $(".festival-icon").load(function() {
      for(i=0; i < $(".festival-icon").length; i++){
        if($('.festival-icon')[i].naturalHeight === 298 && $('.festival-icon')[i].naturalWidth === 298){
          x = $('.image')[i]
          x.children[0].src="http://i.telegraph.co.uk/multimedia/archive/01386/festival1_1386566c.jpg"
        }
      }
    })
  },
  addFestival: function(e){
    e.preventDefault();
    this.projectModel.addFestivalToModel(e);
    this.projectView.update()
    this.projectView.removeLink(e)
  },

  getArtists: function(e){
    e.preventDefault()
    this.projectModel.getArtistsFromDB(e)
  },
  sortFestbyDistance: function(e){
    self = this
    e.preventDefault()
      $.ajax({
      url: '/festivals/sort',
      type: 'GET'
    })
    .done(function(data){ 
      festivals_array = data.result 
      festivals_array.sort(function(a,b){return getDistance(user,a)-getDistance(user,b)})
      var source = $("#fest-template").html();
      var template = Handlebars.compile(source);
      $('.square').remove()
      $("#grid").html(template(festivals_array));
      self.replaceBadPhotos();
    })
  },
  sortFestbyPopularity: function(e){
    self = this
    e.preventDefault()
      $.ajax({
      url: '/festivals/sort',
      type: 'GET'
    })
    .done(function(data){ 
      festivals_array = data.result 
      festivals_array.sort(function(a,b){return b.popularity-a.popularity})
      var source = $("#fest-template").html();
      var template = Handlebars.compile(source);
      $('.square').remove()
      $("#grid").html(template(festivals_array));
      self.replaceBadPhotos();
    })
  },
  sortFestbyDate: function(e){
    self = this
    e.preventDefault()
      $.ajax({
      url: '/festivals/sort',
      type: 'GET'
    })
    .done(function(data){ 
      festivals_array = data.result 
      var source = $("#fest-template").html();
      var template = Handlebars.compile(source);
      $('.square').remove()
      $("#grid").html(template(festivals_array));
      self.replaceBadPhotos();
    })
  },
  sortFestbyRandom: function(e){
    debugger
    self = this
    e.preventDefault()
      $.ajax({
      url: '/festivals/sort',
      type: 'GET'
    })
    .done(function(data){ 
      festivals_array = data.result 
      festivals_array.sort(function() {return 0.5 - Math.random()});
      var source = $("#fest-template").html();
      var template = Handlebars.compile(source);
      $('.square').remove()
      $("#grid").html(template(festivals_array));
      debugger
      self.replaceBadPhotos();
    })
  },
}

