// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function() {
	// Sortable rows
	$('.sorted_table').sortable({
	  containerSelector: 'table',
	  itemPath: '> tbody',
	  itemSelector: 'tr'
	});
});