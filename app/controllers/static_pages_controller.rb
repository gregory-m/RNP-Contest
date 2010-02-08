class StaticPagesController < ApplicationController
  def show
    render :action => params[:id]
  end
end
