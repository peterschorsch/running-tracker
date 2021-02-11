$(function() {
	// VARIABLES
	forefoot_stack = $('#shoe_forefoot_stack');
	heel_stack = $('#shoe_heel_stack');
	heel_drop_paragraph = $('#heel_drop');

	previous_mileage = $('#shoe_previous_mileage');
	new_mileage = $('#shoe_new_mileage');
	mileage_total_paragraph = $('#mileage_total');

	// INITIALLY RUN FUNCTIONS
	calculate_heel_drop();
	calculate_mileage();

	// CHANGE EVENTS FOR SELECTS
	$(forefoot_stack).change(function() {
		calculate_heel_drop();
	});
	$(heel_stack).change(function() {
		calculate_heel_drop();
	});

	// BIND EVENTS FOR NUMBER FIELDS
	$(previous_mileage).bind('keyup mouseup', function () {
    	calculate_mileage();
	});
	$(new_mileage).bind('keyup mouseup', function () {
    	calculate_mileage();
	});

	
	function calculate_heel_drop(){
		heel_drop_paragraph.text((heel_stack.val() - forefoot_stack.val()) + " mm");
	}

	function calculate_mileage(){
		new_total = parseFloat(previous_mileage.val()) + parseFloat(new_mileage.val());
		mileage_total_paragraph.text(new_total.toFixed(2) + " miles");
	}

});