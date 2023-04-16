class Admin::ReportsController < ApplicationController

  def index
    @reports = Report.page(params[:page])
  end

  def show
    @report = Report.find(params[:id])
  end

  def update
    @report = Report.find(params[:id])
    if @report.update(report_params)
      flash[:notice] = "ステータスの更新を行いました。"
      redirect_to request.referer
    end
  end

  private

  def report_params
    params.require(:report).permit(:status)
  end

end
