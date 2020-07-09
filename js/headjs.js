/**
 * 
 */
$(function() {
	$(".subnav").hide();
	
	$("#mainnotice").mouseover(function(){
		$("#subnotice").show();
		$("#subcommu, #subweb, #subwel").hide();
	});
	
	$("#maincommu").mouseover(function(){
		$("#subcommu").show();
		$("#subnotice, #subweb, #subwel").hide();
	});
	
	$("#mainweb").mouseover(function(){
		$("#subweb").show();
		$("#subnotice, #subcommu, #subwel").hide();
	});
	
	$("#mainwel").mouseover(function(){
		$("#subwel").show();
		$("#subnotice, #subcommu, #subweb").hide();
	});
	
	$("#home").mouseover(function() {
		$(".subnav").hide();
	});
	
	$(".subnav").mouseleave(function() {
		$(".subnav").hide();
	});
});