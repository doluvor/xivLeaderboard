class AddAssociateToScores < ActiveRecord::Migration
  def change
    change_table :scores do |t|
      t.belongs_to :encounter, index:true
    end
  end
end
