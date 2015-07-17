class Message
  include Cequel::Record
  extend ElasticSearch

  key :category_id, :timeuuid
  key :id, :timeuuid, auto: true, order: :desc
  column :content, :text

  after_create :add_index

  private
  def add_index
    index = Waistband::Index.new "message"
    index.save(self.category_id, {content: self.content, category: Category.find_by_id(self.category_id).name})
  end
end
