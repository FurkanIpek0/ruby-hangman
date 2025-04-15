# module for documents
module Question
  def self.name_input
    loop do
      puts "Enter your name"
      name = gets.chomp
      return name if name.match?(/\A[a-zA-Z1-9]{3,15}\z/)

      puts "Wrong name input!"
    end
  end

  def self.question_input(question, *answers)
    loop do
      puts question
      answer = gets.chomp.downcase
      return answer if answers.include?(answer)
    end
  end
end
