$(document).ready(function() {

  $("#grid").on("click", ".block", function(e) {
    $(this).flip({
      direction:'lr',
      speed: 300
    });

    $(this).html(generateContent(this))
  });

});

function generateContent(block) {
  name = $(block).data("name");
  city = $(block).data("city");
  date = $(block).data("date");
  playlist = '<embed src="' + $(block).data("playlist") + '">';

  return name + city + date + playlist;
}