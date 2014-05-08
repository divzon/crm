// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require_tree .

setTimeout(closeAlert, 6000);
$('[autofocus]:first').focus();

function closeAlert() {
    $('.alert').alert('close');
}

function start_time() {
	$.post('/user/get_time/', {
	  id: "start"
	}, function(data) {
	  	$("#start_time").val(data);
	  	$(".start_time").text("Call Started");
		$(".start_time").attr("disabled","disabled");
	  	$(".end_time").removeAttr("disabled");
	});
}

function end_time() {
	$.post('/user/get_time/', {
	  id: "end"
	}, function(data) {
	  	$("#end_time").val(data);
	  	$(".end_time").text("Call Ended");
		$(".end_time").attr("disabled","disabled");
	});
}