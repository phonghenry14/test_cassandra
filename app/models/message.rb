class Message
  include Cequel::Record
  extend ElasticSearch

  key :category_id, :timeuuid
  key :id, :timeuuid, auto: true, order: :desc
  column :content, :text

  validates :content, presence: true

  after_create :add_index
  after_update :add_index
  before_destroy :delete_index

  private
  def add_index
    index = Waistband::Index.new self.class.name.downcase
    index.save(self.id, {content: self.content,
      category_id: self.category_id.to_s, category: Category.find_by_id(self.category_id).name})
  end

  def delete_index
    index = Waistband::Index.new self.class.name.downcase
    index.destroy self.category_id
  end
end
