class Api::V1::ProfilesController < ApplicationController

  before_action :doorkeeper_authorize!

  def me
    render json: current_user
  end
end