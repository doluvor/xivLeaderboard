class AddDetailsToScores < ActiveRecord::Migration
  def change
    add_column :scores, :durationS, :string
    add_column :scores, :zone, :string
    add_column :scores, :enemy, :string
  end
end
