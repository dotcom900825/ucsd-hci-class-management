// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery-ui/button
//= require jquery-ui/datepicker
//= require jquery-ui/slider
//= require jquery-ui/spinner
//= require jquery-ui/tooltip
//= require jquery-ui/effect
//= require flatuipro
//= require jquery_ujs
//= require twitter/bootstrap
//= require d3
//= require_tree .

$(document).ready(function(){
  $(".select").select2();
  $("#submit_lab").prop("disabled",true);

  var pointCalculator = function(){
    var total = 0;
    var self_grade = parseInt($('.self_grade').val(), 10);

    $('.number_field').each(function(){
      total += parseInt($(this).val(), 10) || 0;
    })

    $('.total_grade').val(total);

    if(self_grade == 0){
      $('.sa_points').val(0);
      $('.final_grade').val(total);
    }else if(Math.abs(total - self_grade) < 2){
      $('.sa_points').val(2);
      $('.final_grade').val(self_grade);
    }else{
      $('.sa_points').val(1);
      $('.final_grade').val(total);
    }
  }

  if($(".edit_submission").length > 0){
    $('.self_grade, .number_field').change(pointCalculator)
  }

  $('.rubric_field_item').change(function(){
    var score_input = $(this).closest('td').find('.number_field');
    var currentValue = +score_input.val();

    if($(this).prop('checked')){
      score_input.val(currentValue + 1);
    } else {
      score_input.val(currentValue - 1);
    }
    pointCalculator();
  });

  $("#student_lab_certified").change(function() {
    $("#submit_lab").prop("disabled",!$(this).is(":checked"));
  });

})

