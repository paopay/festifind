






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
    $('#explore').hide();
    $('#show_favs').show()
     var source   = $("#some-template").html();
    var template = Handlebars.compile(source);
    $('#each_festival').empty()
    for (x=0;x<this.projectModel.favorites.length;x++) {
      $('#each_festival').append("<b>"+this.projectModel.favorites[x]+"</b><br>")
    }
  }  
}


var ProjectModel = function(){
  this.favorites = []
}

ProjectModel.prototype = {
  addFestivalToModel : function(e){
    update = $(e.target)
    object = $(e.target).data('val')
    this.favorites.push(object)
  }
}


var ProjectController = function(projectView,projectModel){
  this.projectView = projectView
  this.projectModel = projectModel
}

ProjectController.prototype = {
  bindListeners : function(){
    $('.fav_text').on('click',this.addFestival.bind(this))
  },
  addFestival: function(e){
    e.preventDefault();
    this.projectModel.addFestivalToModel(e);
    this.projectView.update()
    this.projectView.removeLink(e)
  }
}

