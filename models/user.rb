require 'SecureRandom'
require_relative '../fake_db'

class User

    # ASSUMPTIONS
    # email is a valid email with @ and domain
    # id is an int equal to or greater than 0
    # access token is a string

    attr_reader :email, :access_token

    def initialize(id, email, access_token)
        @id = id
        @email = email
        @access_token = access_token
    end

    def self.create(email)
        access_token = SecureRandom.hex
        if $db.users.empty?
            id = 1
        else
            id = $db.users.last.id + 1
        end

        user = User.new(id, email, access_token)
        if $db.users[user.email]
            raise 'That email is taken'
        else
            $db.users[user.email] = user
            user = sign_in(user.email, user.access_token)
            return user
        end
    end

    def self.sign_in(email, access_token)
        user = $db.users[email]
        if user && access_token == user.access_token
            $db.current_user = user
            puts "Signed in as " + $db.current_user.email
        elsif user
            puts 'wrong access_token'
        else
            puts 'No user with that email exists'
        end
        return user
    end

end
