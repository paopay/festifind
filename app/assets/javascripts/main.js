






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
  update: function(){
    
    $('#javascript_box').html(this.projectModel.favorites)
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
  }
}

