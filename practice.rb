# create a new Class, User, that has the following attributes:
# - name
# - email
# - password
class User
    attr_accessor :name, :email, :password, :room
    
    def initialize(name, email, password)
      @name = name
      @email = email
      @password = password
    end
    
    # add a method to user so, user can enter to a room
    def enter_room(room)
      @room = room
      room.add_user(self)
      puts "#{name} entered room: #{room.name}."
    end
    
    # add a method to user so, user can send a message to a room
    def send_message(content)
      if @room
        message = Message.new(self, @room, content)
        @room.broadcast(message)
      else
        puts "#{name} does not have a room."
      end
    end
    
    # user.acknowledge_message(room, message)
    def acknowledge_message(message)
      puts "#{name} acknowledged the message: '#{message.content}' from #{message.user.name} in room: #{message.room.name}."
    end
  end
  
  # create a new Class, Room, that has the following attributes:
  # - name
  # - description
  # - users
  class Room
    attr_accessor :name, :description, :users
    
    def initialize(name, description)
      @name = name
      @description = description
      @users = []
    end
    
    # add a method to a room, so it can broadcast a message to all users
    def broadcast(message)
      if @users.any?
        puts "#{message.user.name} in #{name} says: #{message.content}"
        @users.each { |user| user.acknowledge_message(message) }
      else
        puts "No users in the room."
      end
    end
    
    # Method to add a user to the room
    def add_user(user)
      @users << user unless @users.include?(user)
    end
  end
  
  # create a new Class, Message, that has the following attributes:
  # - user
  # - room
  # - content
  class Message
    attr_accessor :user, :room, :content
    
    def initialize(user, room, content)
      @user = user
      @room = room
      @content = content
    end
  end
  
  # Example usage
  user = User.new("Punyisa", "punyisa@example.com", "password123")
  room = Room.new("The Room", "A place for general discussions")
  user.enter_room(room)
  user.send_message("Hello, world!")
  