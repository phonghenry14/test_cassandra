class Note
  include Cequel::Record

  key :id, :timeuuid, auto: true
  column :title, :text
  column :description, :text

  validates :title, presence: true
  validates :description, presence: true

  class << self
    def get_note url
      page = Myapp::GetNote.new url
      Note.create title: page.title, description: page.description
    end
  end
end
