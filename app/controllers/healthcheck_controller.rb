class HealthcheckController < ApplicationController
  def amialive
    Question.first
    render json: { 'msg' => 'I am alive and well' }
  end
end
