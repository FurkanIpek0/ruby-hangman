require_relative "game/board"
require_relative "game/question"
require_relative "game/player"

# class holds game
class Game
  include Question
  def initialize
    @board = Game.create_board
    @player = Game.create_player
  end

  def play
    Question.question_input("Start game?", "yes", "ok")
    loop do
      game_options = options
      puts "Score is #{player.name}: #{player.score}"
      loop do
        puts @board.hangman
        puts @board.opened_treasure_word
        answer = gets.chomp.downcase
        game_status = answer == @board.treasure_word ? win : didnt_win
        break if game_status == false
      end
    end
  end

  def options
    puts "exit/continue/save/load"
    answer = gets.chomp.downcase
    case answer
    when "exit"
      false
    when "continue"
      true
    end
  end

  def win
    puts "#{@player.name} wins this round"
    puts "Word is #{@board.treasure_word}"
    @player.score += 1
    false
  end

  def didnt_win
    @board.opened_treasure_word = @board.give_letter
    if @board.treasure_word == @board.opened_treasure_word
      puts "All words opened you lost"
      false
    else
      true
    end
  end

  def self.create_player
    name = Question.name_input
    Player.new(name)
  end

  def self.create_board
    Board.create
  end
end
