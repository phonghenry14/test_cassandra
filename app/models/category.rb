class Category
  include Cequel::Record
  key :id, :timeuuid, auto: true
  column :name, :text
  column :description, :text
end
