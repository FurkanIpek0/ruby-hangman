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

  attr_reader :opened_treasure_word

  def initialize
    @treasure_word = Board.create_treasure_word
    @opened_treasure_word = Board.create_open_treasure_word(@treasure_word)
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

  def random_letter_index
    @treasure_word.each_with_index.select { |letter, _index| letter[1] == false }.sample[1]
  end

  def self.bring_words_from_file
    File.readlines("docs/english-words.txt")
  end

  def open_treasure_word
    @treasure_word[random_letter_index][1] = true
    @opened_treasure_word = Board.create_open_treasure_word(@treasure_word)
  end

  def bring_parts
    part_number = @treasure_word.length - @treasure_word.select { |letter| letter[1] }.length
    if part_number >= 6
      HANGMAN_STATES[0]
    elsif part_number > 5
      HANGMAN_STATES[1]
    elsif part_number > 4
      HANGMAN_STATES[2]
    elsif part_number > 3
      HANGMAN_STATES[3]
    elsif part_number > 2
      HANGMAN_STATES[4]
    elsif part_number > 1
      HANGMAN_STATES[5]
    else
      HANGMAN_STATES[6]
    end
  end
end
