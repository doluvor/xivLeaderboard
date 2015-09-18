class ScoresController < ApplicationController

  skip_before_filter :verify_authenticity_token, :only => [:create]

  def new
  end

  def index
  	@scores = Score.last(60)

	#score = Score.last
	#decipher = OpenSSL::Cipher::AES.new(128, :CBC)
        #decipher.decrypt
        #decipher.key = "this_is_key_1234"
        #decipher.iv  = "this_is_iv_12345"

        #decipher.padding = 0
	#data = Base64.decode64(URI.unescape(score.zone));
        #deciphered = decipher.update(data) + decipher.final

        #render plain: deciphered, status: :ok
  end

  def createPlain
  	score = Score.create dps:params[:dps], player:params[:player], duration:params[:duration], durationS:params[:durationS], zone:params[:zone], enemy:params[:enemy], job:params[:job], charaID:params[:charaID]

	decipher = OpenSSL::Cipher::AES.new(128, :CBC)
	decipher.decrypt
	decipher.key = "this_is_key_1234"
	decipher.iv  = "this_is_iv_12345"

	decipher.padding = 7

	#deciphered = decipher.update() + decipher.final

  	render plain: "1", status: :ok
  end

  def create
  	#score = Score.create dps:params[:dps], player:params[:player], duration:params[:duration], durationS:params[:durationS], zone:params[:zone], enemy:params[:enemy]

  	decipher = OpenSSL::Cipher::AES.new(128, :CBC)
  	decipher.decrypt
  	decipher.key = "this_is_key_1234"
  	decipher.iv = "this_is_iv_12345"

	#decipher.padding = 0

	data = Base64.decode64(URI.unescape(request.raw_post));
  	deciphered = decipher.update(data) + decipher.final

  	scoreData = JSON.parse deciphered

	score = Score.create dps:scoreData["dps"], player:scoreData["player"], duration:scoreData["duration"], durationS:scoreData["durationS"], zone:scoreData["zone"], enemy:scoreData["enemy"], charaID:scoreData["charaID"], job:scoreData["job"]

  	render json: score, status: :ok
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
