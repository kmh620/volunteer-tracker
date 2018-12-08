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

post("/") do
  title = params.fetch("title")
  project = Project.new({:title => title, :id => nil})
  project.save
  redirect("/")
end

get("/projects/:id") do
  @project_id = params[:id]
  @project = Project.find(params[:id])
  @volunteers = @project.volunteers()
  erb(:project_detail)
end

get("/projects/:id/edit") do
  @project_id = params[:id]
  @project = Project.find(params[:id])
  erb(:edit_project)
end

post("/projects/:id/volunteers") do
  project_id = params[:id]
  @project = Project.find(params[:id])
  name = params["name"]
  id =params["id"]
  volunteer = Volunteer.new(:project_id => @project.id, :name => name, :id => id)
  volunteer.save
  redirect("/")
end

get("/volunteer/:id") do
  @volunteer = Volunteer.find(params[:id])
  erb(:volunteer_detail)
end

patch("/projects/:id/edit") do
  project = Project.find(params[:id])
  title = params.fetch("title")
  project.update({:title => title})
  redirect("/")
end

delete("/projects/:id/edit") do
  project = Project.find(params[:id])
  project.delete
  redirect("/")
end
