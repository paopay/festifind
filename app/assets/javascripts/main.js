var getArtists = (function(){
  return {
    finder: function(){
      $.ajax({
      url: '/artists/find',
      data: {festival:'California Roots Festival 2014'},
      type: 'GET'
    })
    .done(function(data){
      console.log(data)
      var source   = $("#some-template").html();
    var template = Handlebars.compile(source);
    var data = { users: [
      {username: "alan", firstName: "Alan", lastName: "Johnson", email: "alan@test.com" },
      {username: "allison", firstName: "Allison", lastName: "House", email: "allison@test.com" },
      {username: "ryan", firstName: "Ryan", lastName: "Carson", email: "ryan@test.com" }
    ]};
  $("#content-placeholder").html(template(data));
      
    })
    }
  }
})();






$(document).ready(function() {
   


getArtists.finder()



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
    $('#explore').hide();
    $('#show_favs').show()
    $('#each_festival').empty()
    for (x=0;x<this.projectModel.favorites.length;x++) {
      $('#each_festival').append("<span class='greg'>"+this.projectModel.favorites[x]+"</span><br>")
    }
  }  
}
var projectModule = (function(){

})

var ProjectModel = function(){
  this.favorites = []
}

ProjectModel.prototype = {
  addFestivalToModel : function(e){
    update = $(e.target)
    object = $(e.target).data('val')
    this.favorites.push(object)
  },
  getArtistsFromDB : function(e){
    console.log("gettingartists")
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
    this.projectModel.getArtistsFromDB()
  }
}

