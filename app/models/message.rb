require "elasticsearch/model"

class Message
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  include Cequel::Record
  key :id, :timeuuid, auto: true
  column :category_id, :timeuuid, :index => true
  column :content, :text
  timestamps
end
Message.import
