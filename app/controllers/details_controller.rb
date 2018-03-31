class DetailsController < ApplicationController
  #before_action :set_detail, only: [:show, :edit, :update, :destroy]

  def new
    #找出spot
    @detail = Detail.new
    #@WishItem = params[:place_id]
    @spot = Spot.where(place_id: params[:place_id]).first
    #要有如果找不到的防呆
    @schedules = Schedule.find(params[:schedule_id])
    #回傳的view不要含有layout
    render :layout => false
  end

 def create
    @schedules = Schedule.find(params[:detail][:schedule_id])

    #要有如果找不到的防呆
    @spot = Spot.find(params[:detail][:spot_id])
    params[:detail].parse_time_select! :strat_t
    @detail = @spot.details.build(detail_params)

    @detail.schedule = @schedules

    if @detail.save
      @msgResult = "detail was scuccessfully created"
     else
      @msgResult = "detail was failed to create"
     end
  end


  private



  def set_detail
    @detail = Detail.find(params[:id])
  end

  def detail_params
    params.require(:detail).permit(:hr, :category_id, :content, :traffic,:strat_t,:spot_id,:schedule_id)

  end



end