module ElasticSearch
  def search_with_elastic query
    index = Waistband::Index.new "message"
    search = index.search({
      query: {
        query_string: {
          default_field: "_all",
          query: query,
          default_operator: "AND"
        }
      }
    })
    search.results
  end
end
