class CreateRecipes < ActiveRecord::Migration[5.1]
  def change
    create_table :recipes do |t|
    	t.string :title
    	t.text :description
    	t.json :image
    	t.references :user, index: true, foreign_key: true
    	t.timestamps
    end
  end
end
