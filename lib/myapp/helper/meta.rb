require "nokogiri"

module Myapp::Helper::Meta
  include Myapp::Helper::Meta::HtmlStandard
  extend Myapp::Encacher

  cache!(:title) {meta_title}
  cache!(:description) {meta_desc}

end
