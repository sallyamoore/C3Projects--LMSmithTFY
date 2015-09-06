$(document).ready(function() {

  var data = $(".api-response").text();
  songPlayer(data);
});

function songPlayer(url) {
  var embed_url = "https://embed.spotify.com/?uri=";
  var frame = $("<iframe id='frame' width='300' height='80' frameborder='0' allowtransparency='true' src='' autoplay='1'></iframe>");
  var url = url.trim();
  $("body").append(frame);
  frame.attr("src", "" + embed_url + url);
}
