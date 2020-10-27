// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require select2
//= require simplemde.min
//= require_tree .

var enableHighlightJS = function() {
  $('pre code').each(function(i, block) {
    hljs.highlightBlock(block);
  });
};

document.addEventListener("turbolinks:load", function() {
  // enable highlightjs
  enableHighlightJS();

  // close flash alerts
  $('.flash-alert button').click(function (e) {
    $(e.currentTarget).parent().remove();
  });

  $('[data-toggle="tooltip"]').tooltip();

  $('.mde').each(function(editor) {
    new SimpleMDE({ element: editor, forceSync: true });
  });
});
