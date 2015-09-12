class AddCharacterIdToScores < ActiveRecord::Migration
  def change
    add_column :scores, :charaID, :integer
  end
end
