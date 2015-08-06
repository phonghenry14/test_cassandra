module Myapp::Helper::Meta::HtmlStandard
  include Myapp::Helper::DOMFinder

  private
  def meta_title
    doc.title.to_s.strip.encode("utf-8").presence
  end

  def meta_desc
    dom_find "//meta[@name='description']"
  end
end
