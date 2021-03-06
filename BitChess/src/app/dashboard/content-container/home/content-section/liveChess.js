LiveChess = function initAll() {
  //var str = "<iframe src='//lichess.org/tv/frame?bg=auto&theme=auto&embed=" + document.domain + "' class='lichess-tv-iframe' allowtransparency='true' frameBorder='0' style='width: 224px; height: 264px;' title='Lichess free online chess'></iframe>";
  var live = document.createElement('iframe');
  live.setAttribute('src', "//lichess.org/tv/frame?bg=auto&theme=auto&embed=" + document.domain);
  live.setAttribute('class', 'lichess-tv-iframe');
  live.setAttribute('allowtransparency', 'true');
  live.setAttribute('frameBorder', '0');
  live.setAttribute('style', 'min-width:224px; min-height: 264px; margin: 0 auto; width: 224px; height: 264px;');
  live.setAttribute('title', 'Lichess free online chess');
  document.getElementById('liveChess').appendChild(live);
};

if (typeof exports !== 'undefined') {
  exports.LiveChess = LiveChess;
}
