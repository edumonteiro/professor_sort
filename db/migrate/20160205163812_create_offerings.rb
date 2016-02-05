class CreateOfferings < ActiveRecord::Migration
  def change
    create_table :offerings do |t|
      t.references :course, index: true, foreign_key: true
      t.string :letter
      t.string :schedule
      t.references :professor, index: true, foreign_key: true
      t.date :semester

      t.timestamps null: false
    end
  end
end
