// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require chosen-jquery
//= require bootstrap-sprockets
//= require jquery_ujs
//= require chartkick
//= require Chart.bundle
//= require dataTables/jquery.dataTables
//= require_tree .

$(function() {
	make_active_header_link();

	function make_active_header_link(){
		var header = document.getElementById('run-tracker-header');
		trimmed_url = "/".concat(window.location.pathname.split('/')[1]);
		var link_li = document.getElementById(trimmed_url);
		console.log(link_li)
		if (link_li != null){
			link_li.classList.add('active')
		}
	}
});