require_relative './fake_db'
require_relative './models/user'
require_relative './models/post'

class CLIClient

    @@db = FakeDB.instance

    def greet
        puts "Welcome to BLOBOSPHERE"
        puts "type help to see available commands"
    end

    def prompt
        print ">"
        command_arguments = gets.chomp.split(' ')
        case command_arguments.first
        when 'sign-up'
            User.create(command_arguments[1])
        when 'sign-in'
            User.sign_in(command_arguments[1], command_arguments[2])
        when 'list-posts'
            posts = Post.get_posts
            posts.each_with_index { |post, i| puts "#{i + 1}. #{post.text}"}
        when 'create-post'
            post = Post.create(command_arguments[1..-1].join(' '))
            if post
                puts "Created post with ID #{@@db.posts.length - 1}"
            else
                puts "Error creating post"
            end
        when 'edit-post'
            idx = command_arguments[1].to_i
            post = @@db.posts[idx]
            puts "Text: " + post.text
            puts "Enter new text"
            new_text = gets.chomp
            post.edit(new_text)
            puts "Edited!"
        when 'del-post'
            if Post.delete(command_arguments[1].to_i)
                puts "Deleted!"
            end
        when 'help'
            puts "Available commands:"
            if @@db.current_user
                puts "list-posts"
                puts "create-post <text>"
                puts "edit-post <id>"
                puts "del-post <id>"
            else
                puts 'sign-in <email> <access token>'
                puts 'sign-up <email>'
            end
        else
            puts "unknown command"
        end
        prompt
    end

end

cli_client = CLIClient.new
cli_client.greet
cli_client.prompt