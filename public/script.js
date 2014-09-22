$(document).ready(function(){

  $('.top-nav .add').click(function() {
    $('.top-nav .dropdown').slideToggle("fast");
  });

  // add and remove artist boxes

  var addArtistField = function() {
    $('.add-artist-container').append('<div class="artist-box"><input type="text" id="artist" name="artist[]"/><div class="remove-artist-field fa fa-close"></div></div>')
  };

  $('.add-artist-field').click(function() {
    addArtistField();
  });

  $('.add-artist-container').on("click", ".remove-artist-field", function(){
    $(this).parent().remove();
  });


  // search dropdown

  $('.find-box').on("click", function() {
    $(this).next().slideToggle().find('input').focus();
  });

});