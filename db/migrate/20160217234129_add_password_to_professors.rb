class AddPasswordToProfessors < ActiveRecord::Migration
  def change
    add_column :professors, :password_digest, :string
  end
end
