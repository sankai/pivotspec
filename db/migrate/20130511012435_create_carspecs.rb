class CreateCarspecs < ActiveRecord::Migration
  def change
    create_table :carspecs do |t|
      t.string :spectype
      t.string :specname

      t.timestamps
    end
  end
end
