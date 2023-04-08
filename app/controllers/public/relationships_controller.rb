class Public::RelationshipsController < ApplicationController
  before_action :authenticate_member!

  def follow
    @member = Member.find(params[:member_id])
    follow_members = @member.relationships.pluck(:follower_id)
    @relationships = Member.where(id: follow_members).page(params[:page]).per(9)
  end

  def follower
    @member = Member.find(params[:member_id])
    follower_members = @member.passive_relationships.pluck(:member_id)
    @passive_relationships = Member.where(id: follower_members).page(params[:page])
  end


  # 詳細はモデルに記載
  def create
    @other_member = Member.find(params[:member_id])
    return if current_member == @other_member
    Relationship.create!(member_id: current_member.id, follower_id: @other_member.id)
    redirect_to member_path(params[:member_id])
  end

  def destroy
    @relationship = current_member.relationships.find_by(follower_id: params[:member_id])
    @relationship.destroy!
    redirect_to member_path(params[:member_id])
  end

end
