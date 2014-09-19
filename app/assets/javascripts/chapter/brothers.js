// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.


$( document ).on( 'click', '.add_little',function() {
	var clone = $("#template")[0].innerHTML.split("__n").join(this.id);
	$("#little_span").append(clone);
	var sel = $("#select_little" + this.id);
	sel.addClass("chosen-select");
	sel.chosen({allow_single_deselect: true });
	this.id = (parseInt(this.id)+1).toString();
});
