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
  def initialize(difficulty, word_problem=false)
    @diff = difficulty
    @word_problem = word_problem
  end
  
  def random_name
    f = File.open("./names.txt")
    names = f.readline().split("\n")
    names.sample
  end
  
  def wordify(a, b, file)
    f = File.open("./word_#{file}.txt")
    word_problems = f.readline().split("\n")
    word_problems.sample.sub("X", a.to_s).sub("Y", b.to_s).gsub("NAME_1", random_name()).gsub("NAME_2", random_name())
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
    
    a = rand(2..12)
    b = rand(2..12)
     
    type = cattegories.sample
    case type
    when "addition"
      correct_answer = a + b
      if @word_problem
        question = wordify(a, b, "a")
      else
        question = "#{a}+#{b}=x, x=?"
      end
    when "subtraction"
      a, b = [a, b].max, [a, b].min
      correct_answer = a - b
      if @word_problem
        question = wordify(a, b, "s")
      else
        question = "#{a}-#{b}=x, x=?"
      end
    when "multiplication"
      correct_answer = a * b
      if @word_problem
        question = wordify(a, b, "m")
      else
        question = "#{a}X#{b}=x, x=?"
      end
    when "division"
      correct_answer = a
      a = a * b
      if @word_problem
        question = wordify(a, b, "d")
      else
        question = "#{a}/#{b}=x, x=?"
      end
    when "squares"
      correct_answer = a**2
      if @word_problem
        question = wordify(a, b, "q")
      else
        question = "#{a}^2=x, x=?"
      end
    when "roots"
      correct_answer = a
      a = a**2
      if @word_problem
        question = wordify(a, b, "r")
      else
        question = "√#{a}=x, x=?"
      end
    when "exponents"
      a, b = a % 6 + 2 , b % 6
      correct_answer = a**b
      if @word_problem
        question = wordify(a, b, "e")
      else
        question = "#{a}^#{b}=x, x=?"
      end
    when "logarithms"
      a, b = a % 6 + 1, b % 6
      correct_answer = b
      b = a**b
      if @word_problem
        question = wordify(a, b, "l")
      else
        question = "#{a}^x=#{b}, x=?"
      end
    end
    
    return [question, correct_answer]
  end
end

class Quizlet
  def run(questions, word_problem)
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
        a = Question.new(k.to_s, word_problem)
        to_ask = a.generate
        while prev_questions.include? to_ask  do
          to_ask = a.generate
        end
        prev_questions += [to_ask]
        puts "  " + to_ask[0]
        print "Answer: "
        user_answer = gets.gsub(/[^0-9]/, "").to_i
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
q.run({easy:5, medium:5, hard:5}, true)
