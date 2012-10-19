class ServersController < ApplicationController
  respond_to :json

  def create
    @server = Server.find_by_name(params[:server])
    session[:server] = @server.name
    if current_user
      @user = current_user
      @user.map.server = @server
      @user.map.save
      @user.server = @server
      @user.save
      current_user = @user
    end
    render :json => { "location" => "/" } #{@server.name.downcase.strip.gsub(' ', '_').gsub(/[^\w-]/, '')}
  end

  def show
    name = params[:name].titleize
    @user = User.new
    @server = Server.find_by_name(name)
    @rated = Map.find_all_by_server_id(@server.id, :order => "updated_at DESC")
  end

  def points
    name = params[:name].titleize
    server = Server.find_by_name(name)
    points = server.maps.collect(&:points).flatten.to_json
    render :json => points
  end


end
