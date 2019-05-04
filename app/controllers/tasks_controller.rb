class TasksController < ApplicationController

  def index
    @user =
    @tasks = Project.find_by(id: params[:project_id]).tasks
    render json: @tasks, status: 201
  end

  def show
    @task = Task.find_by(id: params[:id])
    render json: @task, status: 201
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      render json: @task, status: 201
    end
  end

  def update
    @task = Task.find_by(id: params[:id])
    if @task.save
      render json: @task, status: 201
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
