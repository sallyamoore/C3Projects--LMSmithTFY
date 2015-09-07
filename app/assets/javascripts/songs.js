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


// IF I GET YOUTUBE WORKING... 

// var tag = document.createElement('script');
// tag.src = "https://www.youtube.com/iframe_api";
// var firstScriptTag = document.getElementsByTagName('script')[0];
// firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
//
// var player;
// function onYouTubeIframeAPIReady() {
//   player = new YT.Player('player', {
//     height: '390',
//     width: '640',
//     videoId: 'M7lc1UVf-VE',
//     events: {
//       'onReady': onPlayerReady,
//       'onStateChange': onPlayerStateChange
//     }
//   });
// }
//
// function onPlayerReady(event) {
//   event.target.playVideo();
// }
//
// var done = false;
// function onPlayerStateChange(event) {
//   if (event.data == YT.PlayerState.PLAYING && !done) {
//     setTimeout(stopVideo, 6000);
//     done = true;
//   }
// }
//
// function stopVideo() {
//   player.stopVideo();
// }
