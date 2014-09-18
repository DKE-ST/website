// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready( function() {
	$( "#sortable" ).sortable({ tolerance: "pointer" });
	$( "#sortable" ).disableSelection();
});

$( document ).on('submit', '.update_contacts', function( event ) {
	var form = $(".update_contacts");
	var order = $( "#sortable" ).sortable("toArray");
	for (var i = 0; i < order.length; i++) {
		$("#officer_" + order[i].toString() + "_position").val(i);
	}
});