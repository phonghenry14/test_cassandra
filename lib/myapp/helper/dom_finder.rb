module Myapp::Helper::DOMFinder

  private
  def dom_find xpath, attr = "content"
    doc.at(xpath).try(:[], attr).to_s.strip.presence
  end

end
