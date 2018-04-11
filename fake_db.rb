require 'singleton'

class FakeDB
    include Singleton
    attr_accessor :users, :posts, :current_user

    def initialize
        @users = {}
        @posts = []
        @current_user = nil
    end

end
