require 'sinatra'
require 'sinatra/reloader'
require 'pony'
require './database.rb'


get '/' do
  erb :home
end

get '/work_history' do
  erb :work_history
end

get '/contact' do
  erb :contact
end

post '/contact' do

  Pony.mail(:to => 'your-email-address', 
            :from => params[:message][:email],
            :subject => params[:message][:subject],
            :body => params[:message][:content],
            :via => :smtp, 
            :smtp => {
            :host     => "your host", #ex "smtp.gmail.com"
            :port     => 'port-number', #ex 587
            :user     => 'your-login-credentials', 
            :password => 'your-pasword', 
            :auth     => :plain, 
            :domain   => "Your domain"
            })

  redirect "/"
end

#jobs routes
get '/jobs' do
  @jobs = Job.all
  erb :'jobs/index'
end

get '/jobs/new' do
  erb :'jobs/new'
end

post '/jobs/new' do
  job = Job.new(params[:job])
  if job.save
    redirect "/jobs/#{job.id}"
  else
    redirect '/jobs/new'
  end
end

get '/jobs/:id' do
  @job = Job.find(params[:id])
  erb :'jobs/show'
end

get '/jobs/:id/edit' do
  @job = Job.find(params[:id])
  erb :'jobs/edit'
end

post '/jobs/:id/edit' do
  job = Job.find(params[:id])
  if job.update_attributes(params[:job])
    redirect "/jobs/#{job.id}"
  else
    redirect "/jobs/#{job.id}/edit"
  end
end

get '/jobs/:id/destroy' do
  job = Job.find(params[:id])
  job.destroy
  redirect '/jobs'
end

