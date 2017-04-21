function play() {
  var a = "white",
    t = function() {
      this.step;
      var t = this;
      this.move = function(e) {
        $(".place").off("click"), $(".piece").off("mousedown");
        var l = $(e.target).attr("data-row"),
          r = "white" == a ? "black" : "white",
          d = $(e.target).attr("data-num");
        $(".piece").removeClass("killable"), $(".place").removeClass("active");
        var i = "white" == a ? -2 : 2,
          o = $('.place[data-row="' + (parseInt(l) + i) + '"][data-num="' + d + '"]');
        "filled" != o.attr("data-filled") && "first" == $(e.target).data("step") && (console.log("first step"), t.step = "white" == a ? -2 : 2, $('.place[data-row="' + (parseInt(l) + t.step) + '"][data-num="' + d + '"]').addClass("active")), t.step = "white" == a ? -1 : 1, i = "white" == a ? -1 : 1, o = $('.place[data-row="' + (parseInt(l) + i) + '"][data-num="' + d + '"]'), "filled" != o.attr("data-filled") && $('.place[data-row="' + (parseInt(l) + t.step) + '"][data-num="' + d + '"]').addClass("active"), "filled" == $('.place[data-row="' + (parseInt(l) + t.step) + '"][data-num="' + (parseInt(d) + 1) + '"]').attr("data-filled") && $('.piece[data-row="' + (parseInt(l) + t.step) + '"][data-num="' + (parseInt(d) + 1) + '"]').hasClass(r) && $('.piece[data-row="' + (parseInt(l) + t.step) + '"][data-num="' + (parseInt(d) + 1) + '"]').addClass("killable"), "filled" == $('.place[data-row="' + (parseInt(l) + t.step) + '"][data-num="' + (parseInt(d) - 1) + '"]').attr("data-filled") && $('.piece[data-row="' + (parseInt(l) + t.step) + '"][data-num="' + (parseInt(d) - 1) + '"]').hasClass(r) && $('.piece[data-row="' + (parseInt(l) + t.step) + '"][data-num="' + (parseInt(d) - 1) + '"]').addClass("killable"), $(".active ").click(function(t) {
          $(e.target).data("step", "clear"), a = "white" == a ? "black" : "white", $(".place").removeClass("active"), $(".piece").removeClass("killable"), $(e.target).animate({
            top: 50 * ($(t.target).attr("data-row") - 1)
          }, 200, function() {
            $('.place[data-row="' + l + '"][data-num="' + d + '"]').attr("data-filled", "none"), $(e.target).attr("data-row", $(t.target).attr("data-row")), $(t.target).attr("data-filled", "filled"), $(".place").off("click"), $(".piece").off("mousedown"), ("8" == $(t.target).attr("data-row") || "1" == $(t.target).attr("data-row")) && $(e.target).attr("data-piece", "Queen")
          })
        }), $(".killable").mousedown(function(t) {
          $(e.target).data("step", "clear"), a = "white" == a ? "black" : "white", $(".place").removeClass("active"), $(".piece").removeClass("killable"), $(e.target).animate({
            left: 50 * ($(t.target).attr("data-num") - 1),
            top: 50 * ($(t.target).attr("data-row") - 1)
          }, 200, function() {
            $('.place[data-row="' + l + '"][data-num="' + d + '"]').attr("data-filled", "none"), $(e.target).attr("data-row", $(t.target).attr("data-row")), $(e.target).attr("data-num", $(t.target).attr("data-num")), $('.place[data-row="' + $(t.target).attr("data-row") + '"][data-num="' + $(t.target).attr("data-num") + '"]').attr("data-filled", "filled"), $(".place").off("click"), $(".piece").off("mousedown"), $(t.target).remove(), $(".place").removeClass("active"), $(".piece").removeClass("killable")
          })
        })
      }
    },
    e = function() {
      this.step;
      this.move = function(t) {
        $(".place").off("click"), $(".piece").off("mousedown"), $(".piece").removeClass("killable"), $(".place").removeClass("active");
        var e = "white" == a ? "black" : "white",
          l = parseInt($(t.target).attr("data-row")),
          r = parseInt($(t.target).attr("data-num")),
          d = [l + 2, l + 2, l - 2, l - 2, l + 1, l + 1, l - 1, l - 1],
          i = [r + 1, r - 1, r + 1, r - 1, r + 2, r - 2, r + 2, r - 2];
        console.log(d);
        for (var o = 0; 8 > o; o++) {
          var c = $('.place[data-row="' + d[o] + '"][data-num="' + i[o] + '"]');
          "filled" == c.attr("data-filled") && $('.piece[data-row="' + d[o] + '"][data-num="' + i[o] + '"]').hasClass(e) ? $('.piece[data-row="' + d[o] + '"][data-num="' + i[o] + '"]').addClass("killable") : c.addClass("active")
        }
        $(".active ").click(function(e) {
          a = "white" == a ? "black" : "white", $(".place").removeClass("active"), $(".piece").removeClass("killable"), $(t.target).animate({
            top: 50 * ($(e.target).attr("data-row") - 1),
            left: 50 * ($(e.target).attr("data-num") - 1)
          }, 200, function() {
            $('.place[data-row="' + l + '"][data-num="' + r + '"]').attr("data-filled", "none"), $(t.target).attr("data-row", $(e.target).attr("data-row")), $(t.target).attr("data-num", $(e.target).attr("data-num")), $(e.target).attr("data-filled", "filled"), $(".place").off("click"), $(".piece").off("mousedown")
          })
        }), $(".killable").mousedown(function(e) {
          a = "white" == a ? "black" : "white", $(".place").removeClass("active"), $(".piece").removeClass("killable"), $(t.target).animate({
            top: 50 * ($(e.target).attr("data-row") - 1),
            left: 50 * ($(e.target).attr("data-num") - 1)
          }, 200, function() {
            $('.place[data-row="' + l + '"][data-num="' + r + '"]').attr("data-filled", "none"), $(t.target).attr("data-row", $(e.target).attr("data-row")), $(t.target).attr("data-num", $(e.target).attr("data-num")), $('.place[data-row="' + $(e.target).attr("data-row") + '"][data-num="' + $(e.target).attr("data-num") + '"]').attr("data-filled", "filled"), $(".place").off("click"), $(".piece").off("mousedown"), $(e.target).remove(), $(".place").removeClass("active"), $(".piece").removeClass("killable")
          })
        })
      }
    },
    l = function() {
      this.move = function(t) {
        $(".place").off("click"), $(".piece").off("mousedown"), $(".piece").removeClass("killable"), $(".place").removeClass("active");
        for (var e = "white" == a ? "black" : "white", l = parseInt($(t.target).attr("data-row")), r = parseInt($(t.target).attr("data-num")), d = 1, i = 1; 8 >= l + i && 8 >= r + d; i++) {
          var o = $('.place[data-row="' + (l + i) + '"][data-num="' + (r + d) + '"]');
          if ("filled" == o.attr("data-filled")) {
            findFilledColor(o, e, l + i, r + d);
            break
          }
          o.addClass("active"), d++
        }
        for (d = 1, i = 1; l - i > 0 && r - d > 0; i++) {
          if (o = $('.place[data-row="' + (l - i) + '"][data-num="' + (r - d) + '"]'), "filled" == o.attr("data-filled")) {
            findFilledColor(o, e, l - i, r - d);
            break
          }
          o.addClass("active"), d++
        }
        for (d = 1, i = 1; 8 >= l + i && r - d > 0; i++) {
          if (o = $('.place[data-row="' + (l + i) + '"][data-num="' + (r - d) + '"]'), "filled" == o.attr("data-filled")) {
            findFilledColor(o, e, l + i, r - d);
            break
          }
          o.addClass("active"), d++
        }
        for (d = 1, i = 1; l - i > 0 && 8 >= r + d; i++) {
          if (o = $('.place[data-row="' + (l - i) + '"][data-num="' + (r + d) + '"]'), "filled" == o.attr("data-filled")) {
            findFilledColor(o, e, l - i, r + d);
            break
          }
          o.addClass("active"), d++
        }
        $(".active ").click(function(e) {
          a = "white" == a ? "black" : "white", $(".place").removeClass("active"), $(".piece").removeClass("killable"), $(t.target).animate({
            top: 50 * ($(e.target).attr("data-row") - 1),
            left: 50 * ($(e.target).attr("data-num") - 1)
          }, 200, function() {
            $('.place[data-row="' + l + '"][data-num="' + r + '"]').attr("data-filled", "none"), $(t.target).attr("data-row", $(e.target).attr("data-row")), $(t.target).attr("data-num", $(e.target).attr("data-num")), $(e.target).attr("data-filled", "filled"), $(".place").off("click"), $(".piece").off("mousedown")
          })
        }), $(".killable").mousedown(function(e) {
          a = "white" == a ? "black" : "white", $(".place").removeClass("active"), $(".piece").removeClass("killable"), $(t.target).animate({
            top: 50 * ($(e.target).attr("data-row") - 1),
            left: 50 * ($(e.target).attr("data-num") - 1)
          }, 200, function() {
            $('.place[data-row="' + l + '"][data-num="' + r + '"]').attr("data-filled", "none"), $(t.target).attr("data-row", $(e.target).attr("data-row")), $(t.target).attr("data-num", $(e.target).attr("data-num")), $('.place[data-row="' + $(e.target).attr("data-row") + '"][data-num="' + $(e.target).attr("data-num") + '"]').attr("data-filled", "filled"), $(".place").off("click"), $(".piece").off("mousedown"), $(e.target).remove(), $(".place").removeClass("active"), $(".piece").removeClass("killable")
          })
        })
      }
    },
    r = function() {
      this.move = function(t) {
        $(".place").off("click"), $(".piece").off("mousedown"), $(".piece").removeClass("killable"), $(".place").removeClass("active");
        for (var e = "white" == a ? "black" : "white", l = parseInt($(t.target).attr("data-row")), r = parseInt($(t.target).attr("data-num")), d = 1; 8 >= r + d; d++) {
          var o = $('.place[data-row="' + l + '"][data-num="' + (r + d) + '"]');
          if ("filled" == o.attr("data-filled")) {
            findFilledColor(o, e, l, r + d);
            break
          }
          o.addClass("active")
        }
        for (d = 1; r - d > 0; d++) {
          if (o = $('.place[data-row="' + l + '"][data-num="' + (r - d) + '"]'), "filled" == o.attr("data-filled")) {
            findFilledColor(o, e, l, r - d);
            break
          }
          o.addClass("active")
        }
        for (i = 1; l + i <= 8; i++) {
          if (o = $('.place[data-row="' + (l + i) + '"][data-num="' + r + '"]'), "filled" == o.attr("data-filled")) {
            findFilledColor(o, e, l + i, r);
            break
          }
          o.addClass("active")
        }
        for (i = 1; l - i > 0; i++) {
          if (o = $('.place[data-row="' + (l - i) + '"][data-num="' + r + '"]'), "filled" == o.attr("data-filled")) {
            findFilledColor(o, e, l - i, r);
            break
          }
          o.addClass("active")
        }
        $(".active ").click(function(e) {
          a = "white" == a ? "black" : "white", $(".place").removeClass("active"), $(".piece").removeClass("killable"), $(t.target).animate({
            top: 50 * ($(e.target).attr("data-row") - 1),
            left: 50 * ($(e.target).attr("data-num") - 1)
          }, 200, function() {
            $('.place[data-row="' + l + '"][data-num="' + r + '"]').attr("data-filled", "none"), $(t.target).attr("data-row", $(e.target).attr("data-row")), $(t.target).attr("data-num", $(e.target).attr("data-num")), $(e.target).attr("data-filled", "filled"), $(".place").off("click"), $(".piece").off("mousedown")
          })
        }), $(".killable").mousedown(function(e) {
          a = "white" == a ? "black" : "white", $(".place").removeClass("active"), $(".piece").removeClass("killable"), $(t.target).animate({
            top: 50 * ($(e.target).attr("data-row") - 1),
            left: 50 * ($(e.target).attr("data-num") - 1)
          }, 200, function() {
            $('.place[data-row="' + l + '"][data-num="' + r + '"]').attr("data-filled", "none"), $(t.target).attr("data-row", $(e.target).attr("data-row")), $(t.target).attr("data-num", $(e.target).attr("data-num")), $('.place[data-row="' + $(e.target).attr("data-row") + '"][data-num="' + $(e.target).attr("data-num") + '"]').attr("data-filled", "filled"), $(".place").off("click"), $(".piece").off("mousedown"), $(e.target).remove(), $(".place").removeClass("active"), $(".piece").removeClass("killable")
          })
        })
      }
    },
    d = function() {
      this.move = function(t) {
        $(".place").off("click"), $(".piece").off("mousedown"), $(".piece").removeClass("killable"), $(".place").removeClass("active");
        for (var e = "white" == a ? "black" : "white", l = parseInt($(t.target).attr("data-row")), r = parseInt($(t.target).attr("data-num")), d = 1; 8 >= r + d; d++) {
          var o = $('.place[data-row="' + l + '"][data-num="' + (r + d) + '"]');
          if ("filled" == o.attr("data-filled")) {
            findFilledColor(o, e, l, r + d);
            break
          }
          o.addClass("active")
        }
        for (d = 1; r - d > 0; d++) {
          if (o = $('.place[data-row="' + l + '"][data-num="' + (r - d) + '"]'), "filled" == o.attr("data-filled")) {
            findFilledColor(o, e, l, r - d);
            break
          }
          o.addClass("active")
        }
        for (i = 1; l + i <= 8; i++) {
          if (o = $('.place[data-row="' + (l + i) + '"][data-num="' + r + '"]'), "filled" == o.attr("data-filled")) {
            findFilledColor(o, e, l + i, r);
            break
          }
          o.addClass("active")
        }
        for (i = 1; l - i > 0; i++) {
          if (o = $('.place[data-row="' + (l - i) + '"][data-num="' + r + '"]'), "filled" == o.attr("data-filled")) {
            findFilledColor(o, e, l - i, r);
            break
          }
          o.addClass("active")
        }
        for (d = 1, i = 1; l + i <= 8 && 8 >= r + d; i++) {
          var o = $('.place[data-row="' + (l + i) + '"][data-num="' + (r + d) + '"]');
          if ("filled" == o.attr("data-filled")) {
            findFilledColor(o, e, l + i, r + d);
            break
          }
          o.addClass("active"), d++
        }
        for (d = 1, i = 1; l - i > 0 && r - d > 0; i++) {
          if (o = $('.place[data-row="' + (l - i) + '"][data-num="' + (r - d) + '"]'), "filled" == o.attr("data-filled")) {
            findFilledColor(o, e, l - i, r - d);
            break
          }
          o.addClass("active"), d++
        }
        for (d = 1, i = 1; l + i <= 8 && r - d > 0; i++) {
          if (o = $('.place[data-row="' + (l + i) + '"][data-num="' + (r - d) + '"]'), "filled" == o.attr("data-filled")) {
            findFilledColor(o, e, l + i, r - d);
            break
          }
          o.addClass("active"), d++
        }
        for (d = 1, i = 1; l - i > 0 && 8 >= r + d; i++) {
          if (o = $('.place[data-row="' + (l - i) + '"][data-num="' + (r + d) + '"]'), "filled" == o.attr("data-filled")) {
            findFilledColor(o, e, l - i, r + d);
            break
          }
          o.addClass("active"), d++
        }
        $(".active ").click(function(e) {
          a = "white" == a ? "black" : "white", $(".place").removeClass("active"), $(".piece").removeClass("killable"), $(t.target).animate({
            top: 50 * ($(e.target).attr("data-row") - 1),
            left: 50 * ($(e.target).attr("data-num") - 1)
          }, 200, function() {
            $('.place[data-row="' + l + '"][data-num="' + r + '"]').attr("data-filled", "none"), $(t.target).attr("data-row", $(e.target).attr("data-row")), $(t.target).attr("data-num", $(e.target).attr("data-num")), $(e.target).attr("data-filled", "filled"), $(".place").off("click"), $(".piece").off("mousedown")
          })
        }), $(".killable").mousedown(function(e) {
          a = "white" == a ? "black" : "white", $(".place").removeClass("active"), $(".piece").removeClass("killable"), $(t.target).animate({
            top: 50 * ($(e.target).attr("data-row") - 1),
            left: 50 * ($(e.target).attr("data-num") - 1)
          }, 200, function() {
            $('.place[data-row="' + l + '"][data-num="' + r + '"]').attr("data-filled", "none"), $(t.target).attr("data-row", $(e.target).attr("data-row")), $(t.target).attr("data-num", $(e.target).attr("data-num")), $('.place[data-row="' + $(e.target).attr("data-row") + '"][data-num="' + $(e.target).attr("data-num") + '"]').attr("data-filled", "filled"), $(".place").off("click"), $(".piece").off("mousedown"), $(e.target).remove(), $(".place").removeClass("active"), $(".piece").removeClass("killable")
          })
        })
      }
    },
    o = function() {
      this.move = function(t) {
        $(".place").off("click"), $(".piece").off("mousedown"), $(".piece").removeClass("killable"), $(".place").removeClass("active");
        var e = "white" == a ? "black" : "white",
          l = parseInt($(t.target).attr("data-row")),
          r = parseInt($(t.target).attr("data-num")),
          d = $('.place[data-row="' + (l + 1) + '"][data-num="' + (r + 1) + '"]');
        "filled" == d.attr("data-filled") ? findFilledColor(d, e, l + 1, r + 1) : d.addClass("active"), d = $('.place[data-row="' + (l + 1) + '"][data-num="' + r + '"]'), "filled" == d.attr("data-filled") ? findFilledColor(d, e, l + 1, r) : d.addClass("active"), d = $('.place[data-row="' + (l + 1) + '"][data-num="' + (r - 1) + '"]'), "filled" == d.attr("data-filled") ? findFilledColor(d, e, l + 1, r - 1) : d.addClass("active"), d = $('.place[data-row="' + l + '"][data-num="' + (r - 1) + '"]'), "filled" == d.attr("data-filled") ? findFilledColor(d, e, l, r - 1) : d.addClass("active"), d = $('.place[data-row="' + l + '"][data-num="' + (r + 1) + '"]'), "filled" == d.attr("data-filled") ? findFilledColor(d, e, l, r + 1) : d.addClass("active"), d = $('.place[data-row="' + (l - 1) + '"][data-num="' + (r + 1) + '"]'), "filled" == d.attr("data-filled") ? findFilledColor(d, e, l - 1, r + 1) : d.addClass("active"), d = $('.place[data-row="' + (l - 1) + '"][data-num="' + r + '"]'), "filled" == d.attr("data-filled") ? findFilledColor(d, e, l - 1, r) : d.addClass("active"), d = $('.place[data-row="' + (l - 1) + '"][data-num="' + (r - 1) + '"]'), "filled" == d.attr("data-filled") ? findFilledColor(d, e, l - 1, r - 1) : d.addClass("active"), $(".active ").click(function(e) {
          a = "white" == a ? "black" : "white", $(".place").removeClass("active"), $(".piece").removeClass("killable"), $(t.target).animate({
            top: 50 * ($(e.target).attr("data-row") - 1),
            left: 50 * ($(e.target).attr("data-num") - 1)
          }, 200, function() {
            function a() {}
            $('.place[data-row="' + l + '"][data-num="' + r + '"]').attr("data-filled", "none"), $(t.target).attr("data-row", $(e.target).attr("data-row")), $(t.target).attr("data-num", $(e.target).attr("data-num")), $(e.target).attr("data-filled", "filled"), $(".place").off("click"), $(".piece").off("mousedown"), a()
          })
        }), $(".killable").mousedown(function(e) {
          a = "white" == a ? "black" : "white", $(".place").removeClass("active"), $(".piece").removeClass("killable"), $(t.target).animate({
            top: 50 * ($(e.target).attr("data-row") - 1),
            left: 50 * ($(e.target).attr("data-num") - 1)
          }, 200, function() {
            $('.place[data-row="' + l + '"][data-num="' + r + '"]').attr("data-filled", "none"), $(t.target).attr("data-row", $(e.target).attr("data-row")), $(t.target).attr("data-num", $(e.target).attr("data-num")), $('.place[data-row="' + $(e.target).attr("data-row") + '"][data-num="' + $(e.target).attr("data-num") + '"]').attr("data-filled", "filled"), $(".place").off("click"), $(".piece").off("mousedown"), $(e.target).remove(), $(".place").removeClass("active"), $(".piece").removeClass("killable")
          })
        })
      }
    };
  $(document).on("click", ".piece", function(i) {
    if ($(this).hasClass(a)) {
      $(".place").off("click");
      var c = $(this).attr("data-piece");
      switch (c) {
        case "Pawn":
          var n = new t;
          n.move(i);
          break;
        case "Knight":
          var s = new e;
          s.move(i);
          break;
        case "Bishop":
          var f = new l;
          f.move(i);
          break;
        case "Rook":
          var p = new r;
          p.move(i);
          break;
        case "Queen":
          var m = new d;
          m.move(i);
          break;
        case "King":
          var w = new o;
          w.move(i)
      }
    } else console.log("turn invalid")
  })
}

function SetPos() {
  $('.place[data-row="7"],.place[data-row="8"]').attr("data-pieceColor", "white").attr("data-filled", "filled"), $('.place[data-row="1"],.place[data-row="2"]').attr("data-pieceColor", "black").attr("data-filled", "filled")
}

function SetPieces() {
  for (var a, t, e, l, r = 1; 32 >= r; r++) {
    switch (r) {
      case 1:
        a = "Rook", t = 1, e = 1, l = "black";
        break;
      case 2:
        a = "Knight", t = 1, e = 2, l = "black";
        break;
      case 3:
        a = "Bishop", t = 1, e = 3, l = "black";
        break;
      case 4:
        a = "Queen", t = 1, e = 4, l = "black";
        break;
      case 5:
        a = "King", t = 1, e = 5, l = "black";
        break;
      case 6:
        a = "Bishop", t = 1, e = 6, l = "black";
        break;
      case 7:
        a = "Knight", t = 1, e = 7, l = "black";
        break;
      case 8:
        a = "Rook", t = 1, e = 8, l = "black";
        break;
      case 17:
        a = "Rook", t = 8, e = 1, l = "white";
        break;
      case 18:
        a = "Knight", t = 8, e = 2, l = "white";
        break;
      case 19:
        a = "Bishop", t = 8, e = 3, l = "white";
        break;
      case 20:
        a = "Queen", t = 8, e = 4, l = "white";
        break;
      case 21:
        a = "King", t = 8, e = 5, l = "white";
        break;
      case 22:
        a = "Bishop", t = 8, e = 6, l = "white";
        break;
      case 23:
        a = "Knight", t = 8, e = 7, l = "white";
        break;
      case 24:
        a = "Rook", t = 8, e = 8, l = "white";
        break;
      default:
        a = "Pawn", t = 1, e = 1, l = "white"
    }
    $("#board").append("Pawn" != a ? '<div class="piece ' + l + '" data-piece="' + a + '" data-row="' + t + '" data-num="' + e + '" style="top:' + 50 * (t - 1) + "px; left:" + 50 * (e - 1) + 'px"></div>' : 17 > r ? '<div class="piece black" data-piece="' + a + '" data-step="first" data-row="2" data-num="' + (r % 9 + 1) + '" style="top:50px; left:' + r % 9 * 50 + 'px"></div>' : '<div class="piece white" data-piece="' + a + '" data-step="first" data-row="7" data-num="' + (r % 8 + 1) + '" style="top:300px; left:' + r % 8 * 50 + 'px"></div>')
  }
}

function DrawBoard() {
  for (var a = 1; 8 >= a; a++)
    for (var t = 1; 8 >= t; t++) $("#board").append('<div class="place row' + a + '" data-row="' + a + '" data-num="' + t + '"></div>');
  $(".place").each(function(a, t) {
    var e, l, r = $(t).data("row"),
      d = $(t).data("num");
    r % 2 ? (e = "rgba(180, 129, 4, 0.2)", l = "rgba(255,255,255,0)") : (l = "rgba(180, 129, 4, 0.2)", e = "rgba(255,255,255,0)"), d % 2 ? $(t).css("background-color", e) : $(t).css("background-color", l), $(t).css("left", 50 * (d - 1) + "px"), $(t).css("top", 50 * (r - 1) + "px")
  })
}
$(function() {
  DrawBoard(); SetPieces(); SetPos(); play();
});
var findFilledColor = function(a, t, e, l) {
  console.log(a);
  var r = $('.piece[data-row="' + e + '"][data-num="' + l + '"]');
  r.hasClass(t) && r.addClass("killable")
};
