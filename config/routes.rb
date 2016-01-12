Rails.application.routes.draw do

  root 'signin#signin', as: :signin, constraints: lambda { |req| req.session[:user_id].nil? }
  root 'admin#home', as: :admin_home, constraints: lambda { |req| ! req.session[:user_id].nil? }

  post '/' => 'signin#submit_signin'
  get '/signout' => 'signin#signout'

  scope 'flows' do
    get '' => 'flow#list'
    scope 'new' do
      get '' => 'flow#create', as: :create_flow
      post '' => 'flow#create'
    end
    scope ':flow_id' do
      get '' => 'flow#show', as: :show_flow
      post 'cancel' => 'flow#cancel', as: :cancel_flow
      post 'pause' => 'flow#pause', as: :pause_flow
      post 'resume' => 'flow#resume', as: :resume_flow
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
