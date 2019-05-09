module Api::V1
  class TasksController < ApplicationController

    def index
      @tasks = Project.find_by(id: params[:project_id]).tasks
      render json: @tasks, status: 200
    end

    # def show
    #   @task = Task.find_by(id: params[:id])
    #   render json: @task, status: 200
    # end

    def create
      @task = Task.new(task_params)
      # Unsure whether to return project or just the project's tasks
      @project = Project.find_by(id: params[:project_id])
      if @task.save
        render json: @project, status: 201
      else
        render json: @task.errors, status: 422
      end
    end

    def update
      @task = Task.find_by(id: params[:id])
      # Toggle completed status from true to false or vice versa
      @task.completed = !@task.completed
      if @task.save
        render json: @task, status: 200
      else
        render json: @task.errors, status: 422
      end
    end

    def destroy
      @task = Task.find_by(id: params[:id])
      @task.destroy
    end


    private

    def task_params
      params.require(:task).permit(:text, :project_id)
    end
  end
end
