class CreatePreferences < ActiveRecord::Migration
  def change
    create_table :preferences do |t|
      t.references :professor, index: true, foreign_key: true
      t.references :offering, index: true, foreign_key: true
      t.string :first_major
      t.string :second_major
      t.string :third_major
      t.string :first_service
      t.string :second_service
      t.string :third_service
      t.string :ttc_proposal_1
      t.string :ttc_proposal_2
      t.string :ttc_proposal_3
      t.text :comments
      t.date :semester

      t.timestamps null: false
    end
  end
end
