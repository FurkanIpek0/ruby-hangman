# class holds board
class Board
  HANGMAN_STATES = [
    "
     +---+
     |   |
         |
         |
         |
         |
    =========
    ",
    "
     +---+
     |   |
     O   |
         |
         |
         |
    =========
    ",
    "
     +---+
     |   |
     O   |
     |   |
         |
         |
    =========
    ",
    "
     +---+
     |   |
     O   |
    /|   |
         |
         |
    =========
    ",
    "
     +---+
     |   |
     O   |
    /|\\  |
         |
         |
    =========
    ",
    "
     +---+
     |   |
     O   |
    /|\\  |
    /    |
         |
    =========
    ",
    "
     +---+
     |   |
     O   |
    /|\\  |
    / \\  |
         |
    =========
    "
  ]

  attr_reader :treasure_word, :opened_treasure_word, :parts

  def initialize
    @treasure_word = Board.create_treasure_word
    @opened_treasure_word = Board.create_open_treasure_word(@treasure_word)
    @parts = Board.create_parts
  end

  def self.create_treasure_word
    Board.bring_words_from_file.sample.chomp.chars.map { |letter| [letter, false] }
  end

  def self.create_open_treasure_word(treasure_word)
    treasure_word.map do |letter|
      if letter[1]
        letter[0]
      else
        "_"
      end
    end
  end

  def self.bring_words_from_file
    File.readlines("docs/english-words.txt")
  end

  def open_treasure_word
    @treasure_word.map { |letter| [letter, false] }
  end

  def self.create_parts
    nil
  end
end
