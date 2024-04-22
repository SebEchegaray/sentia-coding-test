class CreateJoinTableLocationPerson < ActiveRecord::Migration[7.0]
  def change
    create_join_table :locations, :people do |t|
      # t.index [:location_id, :person_id]
      # t.index [:person_id, :location_id]
    end
  end
end
