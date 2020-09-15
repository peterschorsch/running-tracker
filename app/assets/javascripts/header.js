$(function() {
	make_active_header_link();
	
	function make_active_header_link(){
		var header = document.getElementById('run-tracker-header');
		trimmed_url = "/".concat(window.location.pathname.split('/')[1]);
		var link_li = document.getElementById(trimmed_url);
		if (link_li != null){
    		link_li.classList.add('active')
		}
	}

}); 