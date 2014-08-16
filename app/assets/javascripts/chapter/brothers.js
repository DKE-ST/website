// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.


$( document ).on( 'click', '.sel_yr',function() {
	var brothers = $("#year_" + this.id).val();
	if (brothers == "new") {
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
	            			if (data.search(/(Edit|Add) Brother/) > -1) {
	            				window.document.write(data);
	            				window.document.close();
	            			} else {
		            			alert("Brother Information Saved.");
		            			window.location.replace("/brothers/new");
	            			}
	            		}
	            	});
	            },
	            No: function () {
	            	$(this).dialog("close");
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
