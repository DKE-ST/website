class AuditTrailController < ApplicationController
  
  def index
    @versions = PaperTrail::Version.select("*")
    @versions = @versions.where(whodunnit: params[:user]) unless params[:user].blank?
    @versions = @versions.where(item_type: params[:item_type]) unless params[:item_type].blank?
    @versions = @versions.where(item_id: params[:item_id]) unless params[:item_id].blank?
    @versions = @versions.order(created_at: :desc)
  end
  
  def show
    
  end
  
end
