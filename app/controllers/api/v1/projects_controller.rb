module Api::V1
  class ProjectsController < ApplicationController
    before_action :authenticate_user

    def index
      @projects = logged_in_user.projects
      render json: @projects, status: 200
    end

    def show
      @project = Project.find_by(id: params[:id])
      if @project.user_id == logged_in_user.id
        render json: @project, status: 200
      else
        render json: { message: exception.message }, status: :invalid_token
      end
    end

    def create
      @project = Project.new(project_params)
      if @project.save
        render json: @project, status: 201
      else
        render json: @project.errors, status: 422
      end
    end

    def update
      @project = Project.find_by(id: params[:id])
      @project.update(project_params)
      if @project.save
        render json: @project, status: 200
      else
        render json: @project.errors, status: 422
      end
    end

    def destroy
      @project = Project.find_by(id: params[:id])
      # Delete all project tasks before deleting project
      @project.tasks.each { |task| task.destroy }
      @project.destroy
    end


    private

    def project_params
      params.require(:project).permit(:id, :name, :user_id)
    end
  end
end
