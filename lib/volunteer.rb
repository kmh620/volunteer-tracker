require 'pg'
require 'pry'

class Volunteer
attr_reader(:name, :id, :project_id)


def initialize(attributes)
  @name = attributes.fetch(:name)
  @id = attributes.fetch(:id)
  @project_id = attributes.fetch(:project_id)
end

def self.all
  volunteer_list = DB.exec("SELECT * FROM volunteers;")
  volunteers = []
  volunteer_list.each() do |volunteer|
   name = volunteer.fetch("name")
   id = volunteer.fetch("id").to_i
   project_id = volunteer.fetch("project_id").to_i
   volunteers.push(Volunteer.new({:name => name, :id => id, :project_id => project_id}))
 end
 volunteers
end

def save
  volunteer_list = DB.exec("INSERT INTO volunteers (name, project_id) VALUES ('#{@name}', '#{@project_id}') RETURNING id;")
  @id = volunteer_list.first().fetch("id").to_i()
end

def self.project_id
  project = DB.exec("SELECT * FROM projects WHERE id = #{id};").first
  volunteer_list = DB.exec("INSERT INTO volunteers (project_id) VALUES ('#{@project_id}') RETURNING project_id;")
  @project_id = volunteer_list.first().fetch("project_id").to_i()
end

def self.name
  volunteer = DB.exec("SELECT * FROM volunteers WHERE name = '#{name}';").first()
  name = volunteer.fetch("name")
  id = volunteer.fetch("id").to_i
  project_id = volunteer.fetch("project_id").to_i

  new_volunteer = Volunteer.new({:name => name, :id => id, :project_id => project_id})
  new_volunteer
end

def ==(another_volunteer)
  self.name().==(another_volunteer.name()).&(self.id().==(another_volunteer.id())).&(self.project_id().==(another_volunteer.project_id()))
end
#
def self.find(id)
  volunteer = DB.exec("SELECT * FROM volunteers WHERE id = #{id};").first
  name = volunteer.fetch("name")
  id = volunteer.fetch("id").to_i
  project_id = volunteer.fetch("project_id").to_i
  new_volunteer = Volunteer.new({:name => name, :id => id, :project_id => project_id})
  new_volunteer
end




end
