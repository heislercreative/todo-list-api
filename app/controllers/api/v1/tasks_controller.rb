module Api::V1
  class TasksController < ApplicationController
    before_action :authenticate_user

    def index
      if project = Project.find_by(id: params[:project_id])
        if project.user == logged_in_user
          @tasks = project.tasks
          render json: @tasks, status: 200
        else
          render json: { error: 'Access forbidden' }, status: 403
        end
      else
        render json: { error: 'Resource not found'}, status: 404
      end
    end

    # def show
    #   @task = Task.find_by(id: params[:id])
    #   render json: @task, status: 200
    # end

    def create
      @task = Task.new(task_params)
      # Unsure whether to return project or just the project's tasks
      project = Project.find_by(id: params[:project_id])
      if project.user == logged_in_user
        if @task.save
          render json: @project, status: 201
        else
          render json: @task.errors, status: 422
        end
      else
        render json: { error: 'Access forbidden' }, status: 403
      end
    end

    def update
      if @task = Task.find_by(id: params[:id])
        # Toggle completed status from true to false or vice versa
        if @task.project.user == logged_in_user
          @task.completion = !@task.completion
          if @task.save
            render json: @task, status: 200
          else
            render json: @task.errors, status: 422
          end
        else
          render json: { error: 'Access forbidden' }, status: 403
        end
      else
        render json: { error: 'Resource not found'}, status: 404
      end
    end

    def destroy
      if @task = Task.find_by(id: params[:id])
        if @task.project.user == logged_in_user
          @task.destroy
        else
          render json: { error: 'Access forbidden' }, status: 403
        end
      else
        render json: { error: 'Resource not found'}, status: 404
      end
    end


    private

    def task_params
      params.require(:task).permit(:text, :project_id)
    end
  end
end
