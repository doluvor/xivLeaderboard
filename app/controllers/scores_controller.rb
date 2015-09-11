class ScoresController < ApplicationController

  skip_before_filter :verify_authenticity_token, :only => [:create]

  def new
  end

  def index
  	@scores = Score.all
  end

  def createPlain
  	score = Score.create dps:params[:dps], player:params[:player], duration:params[:duration], durationS:params[:durationS], zone:params[:zone], enemy:params[:enemy]

  	render json: score, status: :ok
  end

  def create
  	#score = Score.create dps:params[:dps], player:params[:player], duration:params[:duration], durationS:params[:durationS], zone:params[:zone], enemy:params[:enemy]

  	decipher = OpenSSL::Cipher::AES.new(128, :CBC)
  	decipher.decrypt
  	decipher.key = "this is key 12345"
  	#decipher.iv = iv

  	deciphered = decipher.update(params[:encrypted]) + decipher.final

  	scoreData = JSON.parse deciphered

  	render plain: "#{scoreData["player"]} -- #{params[:encrypted]}", status: :ok
  end

  def testGet
  	uri = URI("http://localhost:3001/scores/create")

  	raw = "{ \"dps\" : 100,
  			\"player\" : \"测试1\" }"

  	cipher = OpenSSL::Cipher::AES.new(128, :CBC)
  	cipher.encrypt
  	#key = cipher.random_key
  	cipher.key = "this is key 12345"
  	#iv = cipher.random_iv

  	encrypted = cipher.update(raw) + cipher.final

  	response = Net::HTTP.post_form uri, "raw" => raw, "encrypted" => encrypted

  	render plain: response.body, status: :ok
  end
end
