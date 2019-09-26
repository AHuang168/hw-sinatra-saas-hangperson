class HangpersonGame
  attr_accessor :word, :guesses, :wrong_guesses, :count

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
    @count = 0
  end

  def check_win_or_lose()    
    word = word_with_guesses  
    if(!(word.include? '-'))
      return :win
    end
    if(@count >= 7)
      return :lose
    end
    return :play
  end

  def guess(word)
    if((word == nil) || (word == ''))
      raise(ArgumentError)
    elsif(!(word.alpha?))
      raise(ArgumentError)
    end
    word.downcase!
    if((@guesses.include? word) || (@wrong_guesses.include? word))
      return false
    end
    if(!(@word.include? word))
      @count += 1
      @wrong_guesses.concat(word)
    else
      @guesses.concat(word)
    end
  end

  def word_with_guesses()
    temp = ''
    @word.each_char { |char|
      if(@guesses.include? char)
        temp.concat(char)
      else
        temp.concat('-')
      end
    }
    return temp
  end

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end

class String
  def alpha?
    !!match(/^[[:alnum:]]+$/)
  end
end