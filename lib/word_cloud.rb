module WordCloud
  class Creator
    include ActiveSupport::Inflector
  
    def initialize(raw_words)
      # these are raw, un-dupped words
      @words = raw_words
      valid_words = File.join(Dir.pwd, "vendor/plugins/word_cloud/lib/word_cloud/words.yml")
      @dictionary = YAML::load( File.open( valid_words ) )
    end
  
    def create(limit = 5)
      puts "building word cloud with #{@words.size} words"
      return if @words.blank?
      
      freq = Hash.new(0)
      @words.each do |word|  
        single = normalize(word)
        freq[single] += 1 if meets_criteria(single)
      end
      freq.sort_by {|x,y| y }.reverse![0..limit-1] #.sort_by {|x,y| x }
    end
    
    def normalize(word)
      word.downcase!
      single = simple_stemmer(singularize(word))
      syn = WordCloud::Synonyms.list[single]
      single = syn if syn
      return single
    end
    
    def meets_criteria(word)
      !WordCloud::Common.list.include?(word) && @dictionary[word]
    end
    
    def simple_stemmer(term)
      endings={"ion" => "or"}
      endings.each do |ending, owner|
        term.gsub!(/(\w*)#{ending}\b/i, "\\1#{owner}")
      end
      return term
    end
  end
end