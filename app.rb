require 'sinatra'
require 'json'

require_relative './fake_db'
$db = FakeDB.instance

require_relative './models/user'
require_relative './models/post'

require './controller'
