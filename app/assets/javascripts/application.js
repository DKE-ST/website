// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require jquery.plugin
//= require jquery.keypad
//= require chosen-jquery
//= require turbolinks
//= require bootstrap
//= require fixedHeader.js
//= require ckeditor/init
//= require_tree .

$('.dropdown-toggle').dropdown();
    $('.dropdown-menu').find('form').click(function (e) {
        e.stopPropagation();
 });
 
function ready() {
	$(".chosen-select").chosen({allow_single_deselect: true });
}
$(document).ready(ready);
$(document).on('page:load', ready);

$.datepicker.setDefaults({
	changeMonth: true,
	changeYear: true,
	showButtonPanel: true,
	dateFormat: "yy-mm-dd"
});
