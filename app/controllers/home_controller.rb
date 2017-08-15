class HomeController < ApplicationController

  include RoomStats

  def index;end

  def upload
  	@stats = get_room_stats(params['input_file'])
  	render action: :index
  end
end
