$(document).ready(function(){
  $('#nav li.add').click(function() {
    $(this).children('.sub').slideToggle("fast");
  });
});
