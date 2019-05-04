class ProjectsController < ApplicationController

  def index
    @projects = User.find_by(id: params[:user_id]).projects
    render json: @projects, status: 201
  end

  def show
    @project = Project.find_by(id: params[:id])
    render json: @project, status: 201
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      render json: @project, status: 201
    end
  end

  def update
    @project = Project.find_by(id: params[:id])
    if @project.save
      render json: @project, status: 201
    end
  end

  def destroy
    @project = Project.find_by(id: params[:id])
    @project.destroy
  end


  private

  def project_params
    params.require(:project).permit(:name, :user_id)
  end
end
