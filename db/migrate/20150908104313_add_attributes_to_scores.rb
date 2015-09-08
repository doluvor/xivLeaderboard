class AddAttributesToScores < ActiveRecord::Migration
  def change
    add_column :scores, :dps, :float
    add_column :scores, :player, :string
    add_column :scores, :duration, :integer
  end
end
