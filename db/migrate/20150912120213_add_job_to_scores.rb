class AddJobToScores < ActiveRecord::Migration
  def change
    add_column :scores, :job, :integer
  end
end
