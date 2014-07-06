def sum(array)
  sum=0
  array.each do |i|
    sum += i
  end
  sum
end

def most_common_value(a)
  a.group_by do |e|
    e
  end.values.max_by(&:size).first
end

class Question
  def initialize(difficulty)
    @diff = difficulty
  end

  
  def generate
    case @diff
    when "easy"
      cattegories = ["addition", "subtraction", "multiplication", "division"]
    when "medium"
      cattegories = ["squares", "roots"]
    when "hard"
      cattegories = ["exponents", "logarithms"]
    end
    
    a = rand(10)
    b = rand(10)
     
    type = cattegories[rand(cattegories.length)]
    case type
    when "addition"
      correct_answer = a + b
      question = "#{a}+#{b}=x"
    when "subtraction"
      correct_answer = a - b
      question = "#{a}-#{b}=x"
    when "multiplication"
      correct_answer = a * b
      question = "#{a}X#{b}=x"
    when "division"
      correct_answer = a
      b = (b % 10) + 1
      a = a * b
      question = "#{a}/#{b}=x"
    when "squares"
      correct_answer = a**2
      question = "#{a}^2=x"
    when "roots"
      correct_answer = a
      a = a**2
      question = "√#{a}=x"
    when "exponents"
      a, b = a % 6 + 2 , b % 6
      correct_answer = a**b
      question = "#{a}^#{b}=x"
    when "logarithms"
      a, b = a % 6 + 1, b % 6
      correct_answer = b
      b = a**b
      question = "#{a}^x=#{b}"
    end
    
    return [question, correct_answer]
  end
end

class Quizlet
  def run(questions)
    score = 0
    wrong = []
    questions[:easy]   ||= 0
    questions[:medium] ||= 0
    questions[:hard]   ||= 0
    
    questions[:easy] %= 20
    questions[:medium] %= 20
    questions[:hard] %= 20
    
    prev_questions = []
    
    puts "Welcome to QUIZLET!"
    
    questions.keys.each do |k|
      questions[k].times do
        a = Question.new(k.to_s)
        to_ask = a.generate
        while prev_questions.include? to_ask  do
          to_ask = a.generate
        end
        puts to_ask[0]
        user_answer = gets.chomp!.to_i
        if user_answer == to_ask[1] 
          puts "Correct!"
          score += 1
        else
          puts "Sorry, the answer was #{to_ask[1]}."
        end
      end
    end  
    percent = score*100/sum(questions.values)
    puts "#{score}/#{sum(questions.values)}, #{percent}%"
    case
    when percent > 90
      puts "Excellent!"
    when percent > 80
      puts "Good!"
    when percent > 70
      puts "Not bad."
    when percent > 60
      puts "Could use same work?"
    else
      puts "Maybe try again?"
    end
  end
end

q = Quizlet.new
q.run({easy:5, medium:5, hard:5})
