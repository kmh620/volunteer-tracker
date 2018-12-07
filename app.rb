require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/project")
require("./lib/volunteer")
require("pg")

DB = PG.connect({:dbname => "volunteer_tracker_test"})

get("/") do
  @projects = Project.all()
  erb(:home)
end

get("/projects") do
  @projects = Project.all()
  erb(:project)
end

get("/projects/new") do
  erb(:home)
end

post("/projects") do
title = params.fetch("title")
project = Project.new({:title => title, :id => nil})
project.save()
@projects = Project.all()
erb(:home)
end

get("/projects/:id") do
  @project = Project.find(params.fetch("id").to_i())
  erb(:project_update)
end

get("/projects/:id/edit") do
  @project = Project.find(params.fetch("id").to_i())
  erb(:rename_project)
end

patch ("/projects/:id/edit") do
 title = params.fetch("title")
 @project = Project.find(params.fetch("id").to_i())
 @project.update({:title => title})
 erb(:project_detail)
end

post("/volunteers") do
  name = params.fetch("name")
  id = params.fetch("id").to_i
  project_id = params.fetch("project_id").to_i()
  volunteer = Volunteer.new({:name => name, :project_id => project_id, :id => id})
  volunteer.save()
  @project = Project.find(id)
  erb(:project)
end


delete("/projects/:id") do
  @project = Project.find(params.fetch("id").to_i())
  @project.delete()
  @projects = Project.all()
  erb(:home)
end
