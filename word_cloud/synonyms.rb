module WordCloud
  class Synonyms
    # Custom list of synonyms to improve word hits.
    
    def self.list
      { "datum" => "data",
        "dev"   => "developer",
        "foody" => "foodie",
        "tech" => "technology",
        "techy" => "technology"
      }
    end
  end
end