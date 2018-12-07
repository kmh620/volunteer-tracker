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

# def save
#   project_list = DB.exec("INSERT INTO projects (name) VALUES ('#{@name}') RETURNING id;")
#   @id = project_list.first().fetch("id").to_i()
# end

# def self.id
#   project = DB.exec("SELECT * FROM projects WHERE id = '#{id}';").first()
#   name = project.fetch("name")
#   id = project.fetch("id").to_i
#   new_id = Project.new({:name => name, :id => id})
#   new_id
# end

# def self.name
#   project = DB.exec("SELECT * FROM projects WHERE name = '#{name}';").first()
#   name = project.fetch("name")
#   id = project.fetch("id").to_i
#   new_project = Project.new({:name => name, :id => id})
#   new_project
# end
#
# def ==(another_project)
#   self.name().==(another_project.name()).&(self.id().==(another_project.id()))
# end
#
# def self.find(id)
#   project = DB.exec("SELECT * FROM projects WHERE id = #{id};").first
#   name = project.fetch("name")
#   id = project.fetch("id").to_i
#
#   new_project = Project.new({:name => name, :id => id})
#   new_project
# end
#
# def delete
#   DB.exec("DELETE FROM projects WHERE id = #{self.id()};")
# end
#
# def update(attributes)
#    @name = attributes.fetch(:name, @name)
#    @id = self.id()
#    DB.exec("UPDATE projects SET name = '#{@name}' WHERE id = #{@id};")
#  end

end
