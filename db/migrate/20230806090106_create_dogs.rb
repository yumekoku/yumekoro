class CreateDogs < ActiveRecord::Migration[6.1]
  def change
    create_table :dogs do |t|
      t.text :body

      t.timestamps
    end
  end
end
