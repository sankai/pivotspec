class CreateSpecs < ActiveRecord::Migration
  def change
    create_table :specs do |t|
      t.string :spectype
      t.string :specname

      t.timestamps
    end
  end
end
