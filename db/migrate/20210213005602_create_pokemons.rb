class CreatePokemons < ActiveRecord::Migration[6.1]
  def change
    create_table :pokemons do |t|
      t.integer :user_id
      t.string :description
      t.string :schedule
      t.string :time

      t.timestamps
    end
  end
end
