// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$( document ).on( 'click', '.filter_btn',function() {
	var data = {group: $("#filter_group").val(),
				year: $("#filter_class").val(),
				house: $("#filter_house").val(),
				admin: $("#filter_admin").val()};
	$.ajax({
		url: '/users/filter',
		type: "POST",
		data: data,
		success: function(data, textStatus, jqXHR) {
			var usr_tbl = $("#user_body");
			usr_tbl.html(data);
		}
	});
});

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

$( document ).on( 'click', '.usr_delete',function() {
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

$( document ).on( 'click', '.usr_sel_yr',function() {
	var brothers = $("#year_" + this.id).val();
	if (brothers == "new") {
		var assoc_msg = "NOTE: You will have to associate the brother information with the username once the entry is created.";
		$('<div></div>').appendTo('body')
	    .html('<div><h6>Would you like to save any changes?</h6></div>')
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
	            	form = $("form");
	            	$.ajax({
	            		url: form[0].action,
	            		type: "POST",
	            		data: form.serialize(),
	            		success: function(data, textStatus, jqXHR) {
	            			if (data.search(/User Management -/) > -1) {
	            				window.document.write(data);
	            				window.document.close();
	            			} else {
		            			alert("User Information Saved.<br>" + assoc_msg);
		            			window.location.replace("/brothers/new");
	            			}
	            		}
	            	});
	            },
	            No: function () {
	            	$(this).dialog("close");
	            	alert(assoc_msg);
	                window.location.replace("/brothers/new");
	            },
	            Cancel: function () {
	                $(this).dialog("close");
	            }
	        },
	        close: function (event, ui) {
	            $(this).remove();
	        }
	    });
	} else {
		brothers = jQuery.parseJSON(brothers);
		var big_selector = $("#select_" + this.id);
		big_selector.html("");
		for (var i in brothers) {
			big_selector.append(new Option(brothers[i][0], brothers[i][1]));
		}
		big_selector.removeClass("hidden");
		$(".clear#" + this.id).removeClass("hidden");
	}
});