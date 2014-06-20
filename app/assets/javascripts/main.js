
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
    $("#list-placeholder").html(template(handleData));   
    })
    }
  }
})();

$(document).ready(function() {   
user = {}
navigator.geolocation.getCurrentPosition(function(position){user.lat = position.coords.latitude, user.lng = position.coords.longitude})
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
  this.allFestivals = []
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
    this.getFestInfoFromServer();
    $('.fav_text').on('click',this.addFestival.bind(this))
    $(document).on('click','.greg',this.getArtists.bind(this))
    $('.distance').on('click', this.sortFestbyDistance.bind(this))
    $('.popularity').on('click', this.sortFestbyPopularity.bind(this))
    $('.upcoming').on('click', this.sortFestbyDate.bind(this))
    $('.random').on('click', this.sortFestbyRandom.bind(this))
    $('.my_favs').on('click', this.showFavs)
    $(document).on('click','.listen',this.showVids)
    $('#search_box').on('keyup', this.autoComplete.bind(this))
    $('#search_button').on('click', this.searchArtists.bind(this))
  },
  autoComplete: function(e){
    e.preventDefault();
    $('#interest-dropdown-row')[0].textContent = ""
    var searchLetters = $("#search_text").val();
    var fests = this.projectModel.allFestivals
    searchResults=[]
    arrayResults=[]
    for(i=0; i<fests.length; i++){
      if(searchLetters == fests[i].display_name.toLowerCase().slice(0,searchLetters.length)){
        searchResults.push(fests[i].display_name)
        arrayResults.push(this.projectModel.allFestivals[i])
      }
    }
    var source = $("#fest-template").html();
    var template = Handlebars.compile(source);
    $('.square').remove()
    $("#grid").html(template(arrayResults));
    if(searchResults.length > 0){
      for(i=0; i<searchResults.length; i++){
        $('#interest-dropdown-row').append('<br>')
        $('#interest-dropdown-row').append(searchResults[i])
      }
    }else{
      $('#interest-dropdown-row').append('<br>')
      $('#interest-dropdown-row').append('No festival matches that, Try again')
    }
  },
  searchArtists: function(e){
    e.preventDefault();
    $('#artist-dropdown-row')[0].textContent = ""
    $.ajax({
      url: '/artists/search/',
      data: {artist: $("#artist_search_text").val()},
      type: 'GET'
    })
    .done(function(data){
      allFestivals = []
      if(data.results.length > 0){
        for(i=0; i<data.results.length; i++){
          $('#artist-dropdown-row').append('<br>')
          $('#artist-dropdown-row').append(data.results[i][0])
          $('#artist-dropdown-row').append(' <i>'+data.results[i][1][0].display_name+'<i>')
          $('#artist-dropdown-row').append(' <i>'+data.results[i][1][0].city_name+'<i>')
          allFestivals.push(data.results[i][1][0])
        }
      }else{
        $('#artist-dropdown-row').append('<br>')
        $('#artist-dropdown-row').append('No artist matches, Try again')
      }
      var source = $("#fest-template").html();
      var template = Handlebars.compile(source);
      $('.square').remove()
      $("#grid").html(template(allFestivals))
    })
  },
  showVids: function(e){
    $.ajax({
      url: '/festivals/videos/',
      data: {artist: $(event.target).attr('data-val'), festival: $(event.target).attr('data-fest')},
      type: 'GET'
    })
    .done(function(data){
      $('iframe')[0].src = data
    })
  },
  showFavs:function(e){
    $('#festivals_box').show();
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
  getFestInfoFromServer: function(){
    self = this
    $.ajax({
      url: '/festivals/sort',
      type: 'GET'
    })
    .done(function(data){ 
      self.projectModel.allFestivals = data.result
      for(i = 0; i < data.result.length; i++){
        self.projectModel.allFestivals[i].start_date = 
        new Date(Date.parse(self.projectModel.allFestivals[i].start_date)).toDateString()
      }
      var source = $("#fest-template").html();
      var template = Handlebars.compile(source);
      $('.square').remove()
      $("#grid").html(template(self.projectModel.allFestivals));
    })
  },
  sortFestbyDistance: function(e){
    e.preventDefault() 
    this.projectModel.allFestivals.sort(function(a,b){return getDistance(user,a)-getDistance(user,b)})
    var source = $("#fest-template").html();
    var template = Handlebars.compile(source);
    $('.square').remove()
    $("#grid").html(template(this.projectModel.allFestivals));
  },
  sortFestbyPopularity: function(e){
    e.preventDefault() 
    this.projectModel.allFestivals.sort(function(a,b){return b.popularity-a.popularity})
    var source = $("#fest-template").html();
    var template = Handlebars.compile(source);
    $('.square').remove()
    $("#grid").html(template(this.projectModel.allFestivals));
  },
  sortFestbyDate: function(e){  
    e.preventDefault()
    this.projectModel.allFestivals.sort(function(a,b) {return Date.parse(a.start_date)-Date.parse(b.start_date)});
    var source = $("#fest-template").html();
    var template = Handlebars.compile(source);
    $('.square').remove()
    $("#grid").html(template(this.projectModel.allFestivals));
  },
  sortFestbyRandom: function(e){
    e.preventDefault()
    this.projectModel.allFestivals.sort(function() {return 0.5 - Math.random()});
    var source = $("#fest-template").html();
    var template = Handlebars.compile(source);
    $('.square').remove()
    $("#grid").html(template(this.projectModel.allFestivals));
  },
}


