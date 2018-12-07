require 'pg'
require 'pry'

class Volunteer
attr_reader(:name, :id)

def initialize(attributes)
  @name = attributes.fetch(:name)
  @id = attributes.fetch(:id)
end

def self.all
  volunteer_list = DB.exec("SELECT * FROM volunteers;")
  volunteers = []
  volunteer_list.each() do |volunteer|
   name = volunteer.fetch("name")
   id = volunteer.fetch("id").to_i
   volunteers.push(Volunteer.new({:name => name, :id => id}))
 end
 volunteers
end

def save
  volunteer_list = DB.exec("INSERT INTO volunteers (name) VALUES ('#{@name}') RETURNING id;")
  @id = volunteer_list.first().fetch("id").to_i()
end

def self.name
  volunteer = DB.exec("SELECT * FROM volunteers WHERE name = '#{name}';").first()
  name = volunteer.fetch("name")
  id = volunteer.fetch("id").to_i
  new_volunteer = Volunteer.new({:name => name, :id => id})
  new_volunteer
end

def ==(another_volunteer)
  self.name().==(another_volunteer.name()).&(self.id().==(another_volunteer.id()))
end
#
def self.find(id)
  volunteer = DB.exec("SELECT * FROM volunteers WHERE id = #{id};").first
  name = volunteer.fetch("name")
  id = volunteer.fetch("id").to_i

  new_volunteer = Volunteer.new({:name => name, :id => id})
  new_volunteer
end


end
