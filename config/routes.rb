Rails.application.routes.draw do

  root 'signin#signin', as: :signin, constraints: lambda { |req| req.session[:user_id].nil? }
  root 'admin#home', as: :admin_home, constraints: lambda { |req| ! req.session[:user_id].nil? }

  post '/' => 'signin#submit_signin'
  get '/signout' => 'signin#signout'

  scope 'workflows' do
    get '' => 'workflow#list'
    scope 'new' do
      get '' => 'workflow#create', as: :create_workflow
      post '' => 'workflow#create'
    end
    scope ':workflow_id' do
      get '' => 'workflow#show', as: :show_workflow
      post 'cancel' => 'workflow#cancel', as: :cancel_workflow
      post 'pause' => 'workflow#pause', as: :pause_workflow
      post 'resume' => 'workflow#resume', as: :resume_workflow
    end
  end

  scope 'handlers' do
    get '' => 'handler#list'
    scope ':name' do
      get '' => 'handler#show', as: :show_handler
    end
  end

  scope 'workers' do
    get '' => 'worker#list'
    scope ':worker_id' do
      get '' => 'worker#show', as: :show_worker
    end
  end
end
