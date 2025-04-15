# module for game class to method space
module Options
  def save
    data = self
    file_length = file_list.length
    file_name = "saves/#{file_length + 1}.save"
    File.open(file_name, "wb") do |file|
      Marshal.dump(data, file)
    end
  end

  def load
    answer = nil
    loop do
      puts "Select file to load"
      puts file_list
      answer = gets.chomp.to_i
      break if answer.between?(0, file_list.length - 1)

      puts "Wrong number input"
    end
    file_name = file_list[answer].split(" - ")[1]
    file_select(file_name)
  end

  def file_list
    Dir["saves/*"].map.with_index { |file, index| "#{index} - #{file}" }
  end

  def file_select(file_name)
    File.open(file_name, "rb") do |file|
      Marshal.load(file)
    end
  end

  def options
    answer = ""
    loop do
      puts "exit/continue/save/load"
      answer = gets.chomp.downcase
      break if %w[exit continue save load].include?(answer)
    end
    case answer
    when "exit"
      false
    when "continue"
      true
    when "save"
      save
      true
    when "load"
      new_load = load
      @board = new_load.board
      @player = new_load.player
      true
    end
  end
end
