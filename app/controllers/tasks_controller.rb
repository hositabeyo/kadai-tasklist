class TasksController < ApplicationController
  before_action :set_tasks, only: [:show, :edit, :update, :destroy]

  def index
    if logged_in?
      @tasks = current_user.tasks.page(params[:page]).per(3)
    end
  end
  
  def show
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = current_user.tasks.build(task_params)
    
    if @task.save
      flash[:saccess] = 'Task が正常に登録されました'
      redirect_to @task
    else
      flash.now[:danger]  = 'Task が登録されませんでした'
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @task.update(task_params)
      flash[:saccess] = 'Task が正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Task が更新されませんでした'
      render :edit
    end
  end
  
  def destroy
    @task.destroy
    
    flash[:success] = 'Task は正常に削除されました'
    redirect_to tasks_url
  end

  private

  def set_tasks
     @task = Task.find(params[:id])
     redirect_to root_url if @task.user != current_user
  end

#Strong Parameter
  def task_params
    params.require(:task).permit(:content, :status)
  end
end