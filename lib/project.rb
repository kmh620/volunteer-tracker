require 'pg'
require 'pry'


class Project

  attr_reader(:p_name, :p_id)

  def initialize(attributes)
    @p_name = attributes.fetch(:p_name)
    @p_id = attributes.fetch(:p_id)
  end

  def self.all
    project_list = DB.exec("SELECT * FROM projects;")
    projects = []
    project_list.each() do |project|
     p_name = project.fetch("p_name")
     p_id = project.fetch("p_id").to_i
     projects.push(Project.new({:p_name => p_name, :p_id => p_id}))
   end
   projects
  end
  #
  # def save
  #
  # end
  #
  # def find
  # end


end
