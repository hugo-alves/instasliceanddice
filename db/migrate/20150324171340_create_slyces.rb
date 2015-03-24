class CreateSlyces < ActiveRecord::Migration
  def change
    create_table :slyces do |t|
      t.string :instaurl
      t.references :user, index: true

      t.timestamps
    end
  end
end
