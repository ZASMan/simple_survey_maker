class CreateContentFilters < ActiveRecord::Migration[5.2]
  def change
    create_table :content_filters do |t|
      t.text :filter_list, array: true, default: []

      t.timestamps
    end
  end
end
