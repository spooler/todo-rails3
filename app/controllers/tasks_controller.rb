class TasksController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_list
  before_filter :find_task, :only => [:edit, :update, :destroy]

  def index
    @tasks = @list.tasks
  end

  def new
    @task = @list.tasks.new
  end

  def create
    @task = @list.tasks.new(params[:task])

    if @task.valid?
      @task.save
      redirect_to list_tasks_url(@list), :notice => "Your task was added"
    else
      render :action => :new
    end
  end

  def edit
  end

  def update
    if @task.update_attributes(params[:task])
      redirect_to list_url(@list), :notice => "The task was updated"
    else
      render :action => :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to list_tasks_url(@list), :notice => "The task was deleted"
  end

private

  def find_list
    @list = current_user.lists.find(params[:list_id])
  end

  def find_task
    @task = @list.tasks.find(params[:id])
  end
end