$(function() {
	remove_all_active_classes();
	initial_current_year_active();

	$(".list-group-item").click(function() {
  		remove_all_active_classes();
		$(this).addClass("active");
	});

	// Function that adds "active" class to sidebar/navbar and panel body for current year
	function initial_current_year_active() {
		var currentYear = new Date().getFullYear();
		
		var navbar = document.getElementById(currentYear+"-navbar");
		var panelBody = document.getElementById(currentYear+"-panel");

		if(navbar!==null || panelBody!==null){
			navbar.classList.add("active");
			panelBody.classList.add("active");
		}
	}

	function remove_all_active_classes(){
		$(".list-group-item, .panel-default").removeClass("active");
	}
});
