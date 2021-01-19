document.addEventListener('DOMContentLoaded', function() {
	makeYearlyRecordsActive()
}, false);


// Function that adds "active" class to sidebar/navbar and panel body for current year
function makeYearlyRecordsActive() {
	var currentYear = new Date().getFullYear();
	var navBar = document.getElementById(currentYear+"-navbar");
	var panelBody = document.getElementById(currentYear+"-panel");

	navBar.classList.add("active");
	panelBody.classList.add("active");
}