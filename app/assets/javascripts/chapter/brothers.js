// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.


$( document ).on( 'click', '.sel_yr',function() {
	var brothers = $("#year_" + this.id).val();
	brothers = jQuery.parseJSON(brothers);
	var big_selector = $("#select_" + this.id);
	big_selector.html("");
	for (var i in brothers) {
		big_selector.append(new Option(brothers[i][0], brothers[i][1]));
	}
	big_selector.removeClass("hidden");
	$(".clear#" + this.id).removeClass("hidden");
});

$( document ).on( 'click', '.clear',function() {
	var big_selector = $("#select_" + this.id);
	big_selector.html("");
	big_selector.append(new Option(null, null));
	big_selector.addClass("hidden");
	$(".clear#" + this.id).addClass("hidden");
});

$( document ).on( 'click', '.add_little',function() {
	var clone = $("#template")[0].innerHTML.split("__n").join(this.id);
	$("#little_span").append(clone);
	this.id = (parseInt(this.id)+1).toString();
});
