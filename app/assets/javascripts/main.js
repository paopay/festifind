$(document).ready(function() {

  $("#grid").on("click", ".block", function(e) {
    if ($(this).find(".image").css("display") != "none") {

      $(this).flip({
        direction:'lr',
        speed: 300
      });

      $(this).find(".image").css("display", "none");
      $(this).find(".info").css("display", "table-cell");
    }
  });

});
