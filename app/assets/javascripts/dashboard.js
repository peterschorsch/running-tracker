$(function() {
	option_select = $('#weekly_total_mileage_goal');
	option_initial_value = option_select.val();

	$('#wtEditCancelBtn').click(function() {
		option_select.val(option_initial_value);
	});
});