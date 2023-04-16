class Public::ReportsController < ApplicationController

  def new
    @report = Report.new
    @member = Member.find(params[:member_id])
  end

  def create
    @member = Member.find(params[:member_id])
    @report = Report.new(report_params)
    @report.reporter_id = current_member.id
    @report.reported_id = @member.id
    if @report.save
      redirect_to root_path, notice: "ご報告有り難う御座いました！順次、対応させていただきます。"
    else
      render :new
    end
  end

  private

  def report_params
    params.require(:report).permit(:reason, :url)
  end

end
