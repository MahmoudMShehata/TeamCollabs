class TaskPoolsController < ApplicationController
  # before_action :require_team_leader, only: [:create, :update, :destroy]
  before_action :find_task_pool, only: [:show, :update, :destroy]

  def index
    @tasks_pools = TaskPool.all
  end

  def show
    @tasks_pool = TaskPool.find(params[:id])
    @tasks = @tasks_pool.tasks
  end

  def create
    # debugger
    @task_pool = TaskPool.create!(name: params[:name], team_leader_id: current_user.id)

    redirect_to task_pools_path

    # if @task_pool.save
    #   redirect_to task_pool_path(@task_pool)
    # else
    #   render :new
    # end
  end

  def update
    if @task_pool.update(task_pool_params)
      redirect_to task_pool_path(@task_pool)
    else
      render :edit
    end
  end

  def destroy
    @task_pool.destroy
    redirect_to task_pools_path
  end

  private

  def find_task_pool
    @task_pool = TaskPool.find(params[:id])
  end

  # def require_team_leader
  #   redirect_to(root_path) unless current_user and current_user.teamleader?
  # end
end