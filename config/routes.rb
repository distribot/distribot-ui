Rails.application.routes.draw do
  root 'public#home'

  scope 'workflows' do
    get '' => 'workflow#list'
    scope 'new' do
      get '' => 'workflow#create'
      post '' => 'workflow#submit_create'
    end
    scope ':workflow_id' do
      get '' => 'workflow#show'
      post 'cancel' => 'workflow#cancel'
      post 'pause' => 'workflow#pause'
      post 'resume' => 'workflow#resume'
    end
  end

  scope 'handlers' do
    get '' => 'handler#list'
    scope ':name' do
      get '' => 'handler#show'
    end
  end

  scope 'workers' do
    get '' => 'worker#list'
    scope ':worker_id' do
      get '' => 'worker#show'
    end
  end
end
