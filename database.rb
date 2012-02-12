require 'sinatra'
require 'sinatra/activerecord'

set :database, 'sqlite://development.db'

class Job < ActiveRecord::Base

end
