class ScoresController < ApplicationController

  skip_before_filter :verify_authenticity_token, :only => [:create]

  def new
  end

  def index
  	@scores = Score.last(60)
  end

  def createPlain
  	score = Score.create dps:params[:dps], player:params[:player], duration:params[:duration], durationS:params[:durationS], zone:params[:zone], enemy:params[:enemy], job:params[:job], charaID:params[:charaID]

  	render json: score, status: :ok
  end

  def create

  	decipher = OpenSSL::Cipher::AES.new(128, :CBC)
  	decipher.decrypt
  	decipher.key = "this_is_key_1234"
  	decipher.iv = "this_is_iv_12345"

    data = Base64.decode64(URI.unescape(request.raw_post));
  	deciphered = decipher.update(data) + decipher.final

  	scoreData = JSON.parse deciphered

    score = Score.create dps:scoreData["dps"], player:scoreData["player"], duration:scoreData["duration"], durationS:scoreData["durationS"], zone:scoreData["zone"], enemy:scoreData["enemy"], charaID:scoreData["charaID"], job:scoreData["job"]

  	render json: score, status: :ok
  end
end
