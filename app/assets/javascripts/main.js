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
  }
}

