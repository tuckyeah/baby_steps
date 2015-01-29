class Hangman
  def initialize
    @secret = choose_secret_word
    @correct_letters = []
    @wrong_letters = []
  end
  
  
  def start
    puts "play again? y / n"
    ans = gets.chomp
    if ans.downcase.include?("y") 
      initialize
      self.run
    else
      puts "Bye!"
    end
  end
  
  def run
    begin 
      print_word
      play_turn
    end until won?
  end
  
private

  def choose_secret_word # returns a word
    ["dog", "cat", "hat"].sample
  end

  def end_game
    # this is what to do when the game has been won
    print_word
    puts "You won!"
    start
  end
  
  def play_turn
    puts "Enter your guess."
    print_wrong_letters
    @guess = gets.chomp
    unless validate_guess(@guess)
      puts "Guess again"
      print_word
      @guess = gets.chomp
    end
    # what if the person puts in more than one letter?
    # or a capital letter?
    # or a letter they've already guessed?
    # how bout another method, `validate_guess(guess)`?
    # @guess could be a local var, `guess`.
    if @secret.include?(@guess)
      @correct_letters << @guess
    else
      @wrong_letters << @guess
      puts "Nope, sorry."
    end
  end
  
  def print_word
    answer = @secret.split("").map do |char|
      @correct_letters.include?(char) ? char : "-"
    end
    puts answer.join(" ")
  end

  def print_wrong_letters 
    puts "Wrong letters: #{@wrong_letters.join(", ")}" if @wrong_letters.size > 0
  end
    
  def validate_guess(guess)
    # if invalid, print the reason and return false
    # if valid, return true
    if guess.downcase.length != 1
      puts "Only one letter, please"
      return false
    elsif @wrong_letters.include?(guess.downcase) || @correct_letters.include?(guess.downcase)
      puts "Already guessed that!"
      return false
    else
      return true
    end
  end  
  
  def won? # returns a boolean
    while @correct_letters.length > 0 do
      # can i turn this into a ternary too?
      # ---
      # no need. you should let `run` manage the
      # end of game, and simply return a boolean here.
      # this whole `won?` method should be about 1 line
      # long. i challenge you. -r
      if (@secret.split("")-@correct_letters).empty?
        end_game
        return true
      else
        #do i have to do 'return false' here? i thought that was implied, but if i remove it, i get stuck in a loop
        # ----
        # a `while` loop that depends on a variable
        # which is never changed within the loop,
        # will always get you stuck. ex:
        # `rorys_age = 26`
        # `while rorys_age == 26 { puts "i'm 26!" }`
        # => infinite loop, because i never change rorys_age
        # think about how many times you really need
        # to run these lines. -r
        return false
      end
    end
  end

end

game = Hangman.new
game.run
