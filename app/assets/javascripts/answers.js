$(document).ready(function() {
    $('a.edit_answer_link').click(function(){
        var answer_id = $(this).data('answerId');
        console.log(answer_id);
        var form = $('#edit_answer_' + answer_id);
        var body = $('#answer_' + answer_id).find('.body');

        if($(this).hasClass('cancel')){
            $(this).html('Edit Answer');
            $(this).removeClass('cancel');
        } else {
            $(this).html('Cancel');
            $(this).addClass('cancel');
        };
        $('.edit_answer_'+ answer_id).toggle();
        form.toggle();
        body.toggle();
    });

    $('form.edit_answer').bind('ajax:success',
        function(e, data, status, xhr){
            response = $.parseJSON(xhr.responseText);
            answer = response.answer;
            console.log(response);
            $('form#edit_answer_' + answer.id).toggle();
            $('#answer_' + answer.id).find('.title').html(answer.body).toggle();


            if ($('a.edit_answer_link').hasClass('cancel')){
                $('a.edit_answer_link').html('Edit Answer');
                $('a.edit_answer_link').removeClass('cancel');
            } else {
                $('a.edit_answer_link').html('Cancel');
                $('a.edit_answer_link').addClass('cancel');
            };
        }).bind('ajax:error',
        function(e, xhr, status, error){
        }).bind('ajax:before',function(){
        $('.answer-errors').html('');
    });

    $('form.new_answer').bind('ajax:success',
        function (e, data, status, xhr) {
            response = $.parseJSON(xhr.responseText);
            answer = response.answer;
            //$('.answers-count').html('Answers count:' + response.answers_count);
            //$('.answers').append('<div class="answer" id="answer_' + answer.id
            //    + '\"><p>' + answer.body + '</p></div>');
            $('input#answer_body').val('');
        }).bind('ajax:error',
        function (e, xhr, status, error) {
            errors = $.parseJSON(xhr.responseText);
            $.each(errors, function (index, message) {
                $('.answer-errors').append("<p>" + message + "</p>")
            });
        }).bind('ajax:before', function () {
        $('.answer-errors').html('');
        });

    questionId = $('.question').data('questionId');
    channel = '/questions/' + questionId + '/answers';

    PrivatePub.subscribe(channel, function(data, channel) {
        console.log(data);
        response = data['response'];
        answers_count = response.answers_count;
        answer = response.answer;

        $('.answers-count').html('Answers count:' + answers_count);
        $('.answers').append('<div class="answer" id="answer_' + answer.id
            + '\"><p>' + answer.body + '</p></div>');
    });
});