require_relative '../fake_db'

class Post

    # ASSUMPTIONS
    # text is string
    # user is an instance of User class
    # created at is a instance of Time class

    attr_reader :user
    attr_accessor :text, :id

    @@db = FakeDB.instance

    def initialize(id, text, user, created_at)
        @id = id
        @text = text
        @user = user
        @created_at = created_at
    end

    def self.create(text)
        id = @@db.posts.length - 1
        post = Post.new(id, text, @@db.current_user, Time.now)
        @@db.posts.push(post)
        return post
    end

    def self.get_posts
        @@db.posts.reverse
    end

    def self.delete(id)
        @@db.posts.slice!(id)
    end

    def edit(new_text)
        @text = new_text
    end


end