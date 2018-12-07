require 'pg'
require 'pry'


class Project

  attr_reader(:title, :id)

  def initialize(attributes)
    @title = attributes.fetch(:title)
    @id = attributes.fetch(:id)
  end

  def self.all
    project_list = DB.exec("SELECT * FROM projects;")
    projects = []
    project_list.each() do |project|
     title = project.fetch("title")
     id = project.fetch("id").to_i
     projects.push(Project.new({:title => title, :id => id}))
   end
   projects
  end

  def save
    project_list = DB.exec("INSERT INTO projects (title) VALUES ('#{@title}') RETURNING id;")
    @id = project_list.first().fetch("id").to_i()
  end

  def self.id
    project = DB.exec("SELECT * FROM projects WHERE id = '#{id}';").first()
    title = project.fetch("title")
    id = project.fetch("id").to_i
    new_id = Project.new({:title => title, :id => id})
    new_id
  end

  def self.title
    project = DB.exec("SELECT * FROM projects WHERE title = '#{title}';").first()
    title = project.fetch("title")
    id = project.fetch("id").to_i
    new_project = Project.new({:title => title, :id => id})
    new_project
  end

  def ==(another_project)
    self.title().==(another_project.title()).&(self.id().==(another_project.id()))
  end

  def self.find(id)
    project = DB.exec("SELECT * FROM projects WHERE id = #{id};").first
    title = project.fetch("title")
    id = project.fetch("id").to_i

    new_project = Project.new({:title => title, :id => id})
    new_project
  end

  def delete
    DB.exec("DELETE FROM projects WHERE id = #{self.id()};")
  end

  def update(attributes)
     @title = attributes.fetch(:title, @title)
     @id = self.id()
     DB.exec("UPDATE projects SET title = '#{@title}' WHERE id = #{@id};")
   end

   def volunteers
    project_volunteers = []
    volunteers = DB.exec("SELECT * FROM volunteers WHERE project_id = #{self.id()};")
    volunteers.each() do |volunteer|
      name = volunteer.fetch("name")
      id = volunteer.fetch("id").to_i()
      project_id = volunteer.fetch("project_id").to_i()

      project_volunteers.push(Volunteer.new({:name => name, :project_id => project_id, :id => id}))
    end
    project_volunteers
  end

end
