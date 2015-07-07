class SearchController < ApplicationController
  def search
    if params[:q].nil?
      @messages = []
    else
      @messages = Message.search params[:q]
    end
  end
end
