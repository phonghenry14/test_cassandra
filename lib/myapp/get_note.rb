require "nokogiri"

class Myapp::GetNote
  include Myapp::Helper::Meta
  include Myapp::Helper::Fetcher
  extend Myapp::Encacher

  attr_reader :url

  def initialize url
    @url = url
  end

  cache!(:response) {fetch url}

  def doc
    return @doc if instance_variable_defined? :@doc
    @doc = Nokogiri::HTML.parse response.body || nil
  end
end
