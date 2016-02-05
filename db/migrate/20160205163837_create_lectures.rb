class CreateLectures < ActiveRecord::Migration
  def change
    create_table :lectures do |t|
      t.references :course, index: true, foreign_key: true
      t.references :professor, index: true, foreign_key: true
      t.string :schedule
      t.date :semester

      t.timestamps null: false
    end
  end
end
