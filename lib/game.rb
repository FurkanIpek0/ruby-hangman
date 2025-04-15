require_relative "game/board"
require_relative "game/question"
require_relative "game/player"
require_relative "game/options"

# class holds game
class Game
  include Options
  attr_reader :board, :player

  include Question
  def initialize
    @board = Game.create_board
    @player = Game.create_player
  end

  def play
    Question.question_input("Start game?", "yes", "ok")
    loop do
      game_options = options
      return if game_options == false

      game_reset
      puts "Score is #{@player.name}: #{@player.score}"
      loop do
        puts @board.bring_parts
        puts @board.opened_treasure_word
        puts "Guess the word"
        answer = gets.chomp.downcase
        game_status = @board.win_controller(answer) ? win : didnt_win
        break if game_status == false
      end
    end
  end

  def win
    @board.open_treasure_word
    puts "#{@player.name} wins this round"
    puts "Word is #{@board.opened_treasure_word}"
    @player.score += 1
    false
  end

  def didnt_win
    @board.open_treasure_word
    if @board.opened_treasure_word.include?("_")
      true
    else
      puts "All words opened you lost word is #{@board.opened_treasure_word}"
      false
    end
  end

  def game_reset
    @board = Game.create_board
  end

  def self.create_player
    name = Question.name_input
    Player.new(name)
  end

  def self.create_board
    Board.new
  end
end
