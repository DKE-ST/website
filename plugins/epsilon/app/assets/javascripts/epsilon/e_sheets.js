// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.


$( document ).ready( function() {
	var id_layout = [$.keypad.HALF_SPACE + $.keypad.numericLayout[0].slice(0,3),
					 $.keypad.HALF_SPACE + $.keypad.numericLayout[1].slice(0,3),
					 $.keypad.HALF_SPACE + $.keypad.numericLayout[2].slice(0,3),
					 $.keypad.HALF_SPACE + $.keypad.numericLayout[3].slice(0,3),
					 $.keypad.numericLayout[1][3]];
					 
					 
	function toggle_display() {
		$(this).toggleClass("hidden");
	}
	
	$('.add_mit_id').keypad({prompt: "Enter your MIT ID",
							 showOn: "button",
							 buttonText: "Sign Up",
							 buttonStatus: "",
							 closeText: "Sign Up",
							 closeStatus: "",
							 layout: id_layout,
							 beforeShow: function(div, inst) {
							 	$(this).removeClass("hidden");
							 	$(this.nextSibling).addClass("hidden");
							 	$('<button id="' + this.form.id +'" class="keypad-special keypad-close">Sign Up</button>'). 
            						appendTo($(div[0].lastChild)).click(function() {
            							$("form#" + this.id).submit();
            						});
							 },
							 onClose: function(value, inst) {
							 	$(this).addClass("hidden");
							 	$(this.nextSibling).removeClass("hidden");
							 }});
	
	$('.drop_mit_id').keypad({prompt: "Enter your MIT ID",
							 showOn: "button",
							 buttonText: "Drop",
							 buttonStatus: "",
							 closeText: "Drop",
							 closeStatus: "",
							 layout: id_layout,
							 beforeShow: function(div, inst) {
							 	$(this).removeClass("hidden");
							 	$(this.nextSibling).addClass("hidden");
							 	$('<button id="' + this.form.id +'" class="keypad-special keypad-close">Drop</button>'). 
            						appendTo($(div[0].lastChild)).click(function() {
            							$("form#" + this.id).submit();
            						});
							 },
							 onClose: function(value, inst) {
							 	$(this).addClass("hidden");
							 	$(this.nextSibling).removeClass("hidden");
							 }});
							 
	$('.add_mit_id').addClass("hidden");
	$('.drop_mit_id').addClass("hidden");
	$('.keypad-trigger').removeClass("hidden");
});
