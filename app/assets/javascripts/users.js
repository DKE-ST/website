// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

/**
 * Event handler for when the filter button is clicked (index.html.erb)
 * --Makes AJAX call to filter users
 */
$( document ).on( 'click', '.user_filter_btn',function(e) {
	e.preventDefault();
	var data = {group: $("#filter_group").val(),
				year: $("#filter_class").val(),
				house: $("#filter_house").val(),
				admin: $("#filter_admin").val()};
	$.ajax({
		url: this.id,
		type: "POST",
		data: data,
		success: function(data, textStatus, jqXHR) {
			var usr_tbl = $("#user_body");
			usr_tbl.html(data);
		}
	});
});

/**
 * Event handler for check kerberos button (edit.html.erb)
 * --Makes AJAX call to check if username has a valid kerberos
 *   associated with it
 */
$( document ).on( 'click', '.krb_chk',function() {
	var data = {uname: $("#user_uname").val()};
	$("#krb_field").html("Loading...");
	$.ajax({
		url: '/users/kerberos',
		type: "POST",
		data: data,
		success: function(data, textStatus, jqXHR) {
			$("#krb_field").html(data);
		}
	});
});

/**
 * Event handler for removing users via AJAX call
 * --Used in index.html.erb & edit.html.erb
 */
$( document ).on( 'click', '.usr_delete',function(e) {
	e.preventDefault();
	var id = this.id;
	var element = this.parentElement.parentElement;
	$('<div></div>').appendTo('body')
    .html('<div><h6>Would you like to delete the corresponding brother information (if applicable)?</h6></div>')
    .dialog({
        modal: true,
        title: 'Delete message',
        zIndex: 10000,
        autoOpen: true,
        width: 'auto',
        resizable: false,
        buttons: {
            Yes: function () {
            	$(this).dialog("close");
            	$.ajax({
					url: '/users/' + id,
					type: "DELETE",
					data: {all: true},
					success: function(data, textStatus, jqXHR) {
						element.remove();
						alert(data);
						if (document.URL.search("edit") != -1) {
							window.location.replace("/users");
						}
					}
				});
            },
            No: function () {
            	$(this).dialog("close");
            	$.ajax({
					url: '/users/' + id,
					type: "DELETE",
					data: {all: false},
					success: function(data, textStatus, jqXHR) {
						element.remove();
						alert(data);
						if (document.URL.search("edit") != -1) {
							window.location.replace("/users");
						}
					}
				});
            },
            Cancel: function () {
                $(this).dialog("close");
            }
        },
        close: function (event, ui) {
            $(this).remove();
        }
    });
});

/**
 * Event handler for querying mit ldap directory for user info
 * --Used in add_pledges.html.erb
 * --NOTE: This is the form we shoul be using for ajax calls.  Pulls fields and url form the form
 */
$( document ).on('submit', '.query', function( event ) {
	var form = $(".query");
	var button = $("#query_submit");
	button.val("Searching...");
	$.ajax({
		url: form[0].action,
		type: "POST",
		data: form.serialize(),
		success: function(data, textStatus, jqXHR) {
			var res_out = $("#query_results");
			res_out.html(data);
			button.val("Search");
		}
	});
	event.preventDefault();
});

/**
 * Event handler for adding pledge to the new_users form
 * --Used in add_pledges.html.erb
 */
$( document ).on( 'click', '.pledge_add',function() {
	this.innerHTML = "Remove";
	this.className = "pledge_remove";
	var element = this.parentElement.parentElement;
	$("#new_class").append(element.outerHTML);
	element.remove();
});

/**
 * Event handler for removing user info from the new_users form
 * --Used in add_pledges.html.erb
 */
$( document ).on( 'click', '.pledge_remove',function( event ) {
	this.parentElement.parentElement.remove();
	event.preventDefault();
});