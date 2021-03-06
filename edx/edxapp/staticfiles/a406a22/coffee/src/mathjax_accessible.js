// Generated by CoffeeScript 1.6.1
(function() {

  $(function() {
    var isMPInstalled;
    if (window.navigator.appName === "Microsoft Internet Explorer") {
      isMPInstalled = function(boolean) {
        var oMP;
        try {
          oMP = new ActiveXObject("MathPlayer.Factory.1");
          return true;
        } catch (e) {
          return false;
        }
      };
      if ((typeof MathJax !== "undefined" && MathJax !== null) && !isMPInstalled()) {
        $("#mathjax-accessibility-message").attr("aria-hidden", "false");
      }
      if ((typeof MathJax !== "undefined" && MathJax !== null) && $("#mathplayer-browser-message").length > 0) {
        return $("#mathplayer-browser-message").attr("aria-hidden", "false");
      } else {
        return $("#mathjax-accessibility-message").attr("aria-hidden", "true");
      }
    }
  });

}).call(this);
