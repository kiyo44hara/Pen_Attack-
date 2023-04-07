class Public::RelationshipsController < ApplicationController
  before_action :authenticate_member!

  def show
    @range = params[:range]
    @member = Member.find(params[:member_id])
    if @range == "フォロー"
        follow_members = @member.relationships.pluck(:follower_id)
        @relationships = Member.where(id: follow_members).page(params[:page])
    else        #"フォロワー"
        follower_members = @member.passive_relationships.pluck(:member_id)
        @passive_relationship = Member.where(id: follower_members).page(params[:page])
    end
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
