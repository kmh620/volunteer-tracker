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




end
