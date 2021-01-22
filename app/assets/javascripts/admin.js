document.addEventListener('DOMContentLoaded', function() {
	makeYearlyRecordsActive()
}, false);


// Function that adds "active" class to sidebar/navbar and panel body for current year
function makeYearlyRecordsActive() {
	var currentYear = new Date().getFullYear();
	var panelBody = document.getElementById(currentYear+"-panel");

	panelBody.classList.add("active");
}