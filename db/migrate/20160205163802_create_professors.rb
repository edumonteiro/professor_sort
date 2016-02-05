class CreateProfessors < ActiveRecord::Migration
  def change
    create_table :professors do |t|
      t.string :name
      t.string :email
      t.string :kind
      t.string :status

      t.timestamps null: false
    end
  end
end
