module Api::V1
  class ProjectsController < ApplicationController
    before_action :authenticate_user

    def index
      @projects = logged_in_user.projects
      render json: @projects, status: 200
    end

    def show
      if @project = Project.find_by(id: params[:id])
        if @project.user == logged_in_user
          render json: @project, status: 200
        else
          render json: { error: 'Access forbidden' }, status: 403
        end
      else
        render json: { error: 'Resource not found'}, status: 404
      end
    end

    def create
      @project = logged_in_user.projects.new(project_params)
      if @project.save
        render json: @project, status: 201
      else
        render json: @project.errors, status: 422
      end
    end

    def update
      if @project = Project.find_by(id: params[:id])
        if @project.user == logged_in_user
          @project.update(project_params)
          if @project.save
            render json: @project, status: 200
          else
            render json: @project.errors, status: 422
          end
        else
          render json: { error: 'Access forbidden' }, status: 403
        end
      else
        render json: { error: 'Resource not found'}, status: 404
      end
    end

    def destroy
      if @project = Project.find_by(id: params[:id])
        if @project.user == logged_in_user
          # Delete all project tasks before deleting project
          @project.tasks.each { |task| task.destroy }
          @project.destroy
        else
          render json: { error: 'Access forbidden' }, status: 403
        end
      else
        render json: { error: 'Resource not found'}, status: 404
      end
    end


    private

    def project_params
      params.require(:project).permit(:id, :name)
    end
  end
end
