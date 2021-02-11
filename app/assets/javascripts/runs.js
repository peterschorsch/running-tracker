$(function() {
	$('.chosen-select').chosen();

	$('#runs_table').dataTable( {
		/* Disable initial sort */
		"aaSorting": [],
		"pageLength": 25
	});
});