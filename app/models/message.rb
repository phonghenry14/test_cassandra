class Message
  include Cequel::Record
  extend ElasticSearch
  include PageViews

  key :category_id, :timeuuid
  key :id, :timeuuid, auto: true, order: :desc
  column :content, :text

  validates :content, presence: true

  after_create :add_index, :initialize_pagevew
  after_update :add_index
  before_destroy :delete_index, :destroy_pageview!

  def redis_key
    "message_#{self.id}"
  end

  private
  def index
    Waistband::Index.new self.class.name.downcase
  end

  def add_index
    index.save(self.id, {content: self.content,
      category_id: self.category_id.to_s, category: Category.find_by_id(self.category_id).name})
  end

  def delete_index
    index.destroy self.category_id
  end
end
