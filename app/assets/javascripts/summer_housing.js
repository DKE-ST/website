// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$( document ).on( 'click', '.contact_toggle',function() {
	//var data = {id: this.value};
	var contactStatus = this.parentElement.previousElementSibling;
	$.ajax({
		url: this.id,
		type: "PUT",
		//data: data,
		success: function(result, textStatus, jqXHR) {
			contactStatus.innerHTML = result;
		}
	});
});