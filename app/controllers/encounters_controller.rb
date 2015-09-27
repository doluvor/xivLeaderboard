class EncountersController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:create]

  def index
    @encounter = Encounter.last(10)
  end

  def create

    decipher = OpenSSL::Cipher::AES.new(128, :CBC)
    decipher.decrypt
    decipher.key = "this_is_key_1234"
    decipher.iv = "this_is_iv_12345"

    data = Base64.decode64(URI.unescape(request.raw_post));
    deciphered = decipher.update(data) + decipher.final

    encounterData = JSON.parse deciphered

    encounter = Encounter.create duration:encounterData["duration"], durationS:encounterData["durationS"], zone:encounterData["zone"], enemy:encounterData["enemy"]

    encounterData["scores"].each do |scoreData|
      score = Score.create dps:scoreData["dps"], player:scoreData["player"], job:scoreData["job"], charaID:scoreData["charaID"], encounter_id:encounter.id
    end

    render json: encounter, status: :ok
  end
end
