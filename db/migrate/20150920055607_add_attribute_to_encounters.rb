class AddAttributeToEncounters < ActiveRecord::Migration
  def change
    add_column :encounters, :duration, :integer
    add_column :encounters, :durationS, :string
    add_column :encounters, :zone, :string
    add_column :encounters, :enemy, :string
  end
end
