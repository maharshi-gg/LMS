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
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery3
//= require jquery_ujs
//= require_tree .
//= require_self

var ready = function () {
    // $('#more2come').hide();
    $('#student_sub_form').show();
    $('#librarian_sub_form').hide();
    //$('#lib2come').hide();
    $('#user_role').change(function(){
        if($('#user_role').val()=='user'){
            $('#more2come').show();
            $('#student_sub_form').show();
            $('#librarian_sub_form').hide();
            $('#user_student_name').prop("required",true);
            $('#user_student_education').prop("required",true);
            $('#user_student_university').prop("required",true);
        }
        else if($('#user_role').val()=='librarian') {
            $('#more2come').show();
            $('#student_sub_form').hide();
            $('#librarian_sub_form').show();
            $('#user_librarian_name').prop("required",true);
            $('#user_library_name').prop("required",true);
        }
        else {
            $('#more2come').hide();
            $('#student_sub_form').hide();
            $('#librarian_sub_form').hide();
        }
    });

    $('#mb_field').hide();
    $('#student_education').change(function(){
        if($('#user_student_education').val()=='Masters') {
            $('#user_student_max_books').val = 4;
        }
        else if ($('#user_student_education').val()=='Undergraduate') {
            $('#user_student_max_books').val = 2;
        }
        else if ($('#user_student_education').val()=='PhD') {
            $('#user_student_max_books').val = 6;
        }
        else $('#user_student_max_books').val = 2;
    });

};

$(document).ready(ready);
$(document).on('turbolinks:load',ready);
