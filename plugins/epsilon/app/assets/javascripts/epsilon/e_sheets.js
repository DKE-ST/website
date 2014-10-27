// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$( document ).on( 'click', '.public_e_sheet',function( event ) {
	event.preventDefault();
});

$( document ).ready( function() {
	$('#mit_id').keypad({showOn: 'form'});
});
