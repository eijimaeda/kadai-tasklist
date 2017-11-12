class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  before_action :set_task, only: [:show, :edit, :update, :destroy ]
  
#def index
#  @tasks = Task.all.page(params[:page])
#end

  def show
    set_task
  end

  def new
    @task = current_user.tasks.build
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = 'Taskが正常に作成されました'
      redirect_to root_url
    else
      @tasks = current_user.tasks.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'Taskが作成されませんでした'
      render 'toppages/index'
    end
  end

  def edit
    set_task
  end

  def update
    set_task
    if @task.update(task_params)
      flash[:success] = 'Taskが正常に更新されました'
      redirect_to @task
    else
      flash[:danger] = 'Taskは更新されませんでした'
      render :edit
    end
  end

  def destroy
    @task.destroy
    flash[:success] = 'taskは正常に削除されました'
    redirect_to root_path
  end
  
  private
  
  def set_task
    @task = current_user.tasks.find_by(id: params[:id])
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
  
  def task_params
    params.require(:task).permit(:content, :deadline, :status)
  end
  
end
