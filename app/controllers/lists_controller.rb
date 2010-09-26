class ListsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_list, :except => [:index, :new, :create]

  def index
    @lists = current_user.lists
  end

  def new
    @list = current_user.lists.new
  end

  def create
    @list = current_user.lists.new(params[:list])

    if @list.valid?
      @list.save
      redirect_to list_tasks_url(@list), :notice => "Your list \"#{@list.name}\" was created"
    else
      render :action => :new
    end
  end

  def edit
  end

  def update
    if @list.update_attributes(params[:list])
      redirect_to list_tasks_url(@list), :notice => "Your list was updated" 
    else
      render :action => :edit
    end
  end

  def show
    redirect_to list_tasks_url(@list)
  end

  def destroy
    @list.destroy
    redirect_to lists_url, :notice => "Your list \"#{@list.name}\" was deleted"
  end

private

  def find_list
    @list = current_user.lists.find(params[:id])
  end
end