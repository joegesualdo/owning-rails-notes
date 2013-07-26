class String
  def pluralize
    self + "s"
  end
end

puts "Hello".pluralize



has_many :roles, dependent => :destroy
#instaed of 
self.has_many(:roles. {dependent => :destroy}) #dont need bracket when hash is last argument


# All of these are the same
x = 1 + 2
x = 1.+(2)
x = 1.send(:+,2)


# Everything is an object, so everything has a class
"hi".class # +=> String
String.class #=> Class
Class.class # => Class

#########################

class Pony

  def eat #This is a instance method

  end

  def self.eat_all # this is a class method, because when we are in body of class self is equal to class. This is same as writing 'def Pony.eat_all'

  end

end

Pony.new.eat # Creates a new instance before you can call the instance method
Pony.eat_all # Can call method without an instance, because it's calling directly on the class

module Vegetarian
  def eat_meat?
    false
  end
end

class Pony # we reopen the class to add the vegatian model
  include Vegetarian # inlude takes all the methods you have defined in a module and adds them as INSTANCE methods on a class. Actually a private method of class, where extend is a public.
end

Pony.new.eat_meat? # This eat_meat method is avaiable to an instance of Pony because we included the Vegetarian module in our class

class Pony
  extend Vegetarian # extend takes all the mehtods you have defined in a module and adds them as CLASS methods on a class
end

Pony.eat_meat? # This eat_meat method is available on the class because we included the vegetarian module

# can also call extend like this
s = "hi"
s.extend Vegetarian
s.eat_meat?

# Difference between include and extend is extend is a public method of every object, so you can extend any object with a specific modul. It will add those methods to that one single instance!
# INCLUDE shoudl ONLY be called in the body of a class, so it's a private method.
# EXTEND can be called outside the body of a class, so it's a public mehtod

class Pony
  extend Vegetarian # same as putting self.extend Vegetarian, which is same as Pony.extend Vegetarian.
end

# Modules are also used for namespacing
module ActiveRecord
  class Base
    def self.has_many(name, options={}) # We call this method in our User class below
    end
  end
end

class User < ActiveRecord::Base
  has_many :roles, dependent => :destroy # When you dont see the reciever, message will always be sent to self. So same as self.has_many, which is same as User.has_many(:roles, {:dependent => :destroy})
end


# BLOCKS and PROCS

my_proc = proc do
  puts "Yeaahhh"
end

my_proc.call # to make your proc run, you call the .call method on the proc. # this will execute the code you stored in the proc

# difference between Proc and Bloc, is Block is not an object. So if you want to turn a block into an object, you need to store it inside a proc
# aftet the my_pro = proc is a block (from do to end)
# Procs are objects that wrap bocks of code
# the way you play with blocks of code and move them around are to store them in procs

def hug
  puts "{"
  yield # Any block of code that is passed to the hug method, will be executed here. Calling yield will execute the block of doe
  puts "}"
end

hug { puts "me"} # This passes a block into the hug method.

# The other way to call a block of code:
def hug(&block) # The &block tells ruby that if there is a block passed to this method then create a proc and store it in &block
  puts "{"
  block.call # Since we are now wrapping our block as a proc, our block is an object that we can call useing .call. This will be slower than yield because ruby needs to create an object
  puts "}"
end

hug { puts "me"} # Can also use 'hug do puts "me" end'. This will give us the same result as above

# This is how Rails Router works. TODO: Watch this section again. Starts around 30 min
class Router
  def initialize
    @routes = {}
  end

  def match(options)
    @routes.update(options)
  end

  def routes(&block) # The & turns a block into a proc
    instance_eval(&block) # This evaluates the call in the current instance. The & inside a method turn the proc back into a block. instance_aval executes a block within a different context, the context is the instance. Evaluating the block within the context of the current instance
  end
end

Router.new.routes do
  match "/users" => 'users#index' # Same as match({"/users" => 'users#index})
  match "/users" => 'sessions#index'
end






# ActionController = Controller role is taken care of by this and ActionDispatch
# ActionView = 
# ActiveRecord = The one responsible for stuff you store in database

#Principle rules for mvc:
# models/: Is this holding data or buisness login specific to my app?
# views/,helpers/: Is it presenting information about my models
# controllers/: Is it handling an event or interation with the use?



#ActiveRecord
# ActiveRecord is the  simplest way to access data from a database
# Creates a class that maps to one single table in the database and the attributes of this class to a column in a database
# One of the downside, if you add a new column in database, you also need to add an attribute to the class. Need to keep them the same! Rails actually takes care of this downside




