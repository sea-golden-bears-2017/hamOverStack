post '/answers/:id' do
  answer = Answer.find(params[:id])
  question = Question.find(answer.question_id)
  #Not currently working Ajax
  if request.xhr?
    if answer.best_answer # true -- we do have a best answer
      answer.best_answer = false
      answer.save
    else
      answer.best_answer = true
      answer.save
      p "~" * 100
      erb :'/questions/_show', :locals => {question: question, answer: answer}, :layout => false
    end
    #if its ajax then dynamically load the best_answer
  else
    if answer.best_answer
      answer.best_answer = false
      answer.save
      redirect "/questions/#{question.id}"
    else
      question.answers.each do |ans|
        ans.best_answer = false
        ans.save
      end
      answer.best_answer = true
      answer.save
      redirect "/questions/#{question.id}"
    end
  end
end

post '/questions/:question_id/answers' do
  @answer = Answer.create(description: params[:description], user_id: session[:user_id], question_id: params[:question_id])

  @error_messages = @answer.errors.full_messages
  if @error_messages.length > 0
    @question = Question.find(params[:question_id])
    erb  :"/questions/show"
  else
    redirect "/questions/#{params[:question_id]}"
  end
end
