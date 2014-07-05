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
  
  def addition
    a = rand(10)
    b = rand(10)
    c = a + b
    puts "#{a}+#{b}=x"
    print "x="
    answer = gets.chomp!.to_i
    if c == answer
      ["addition", true]
    else
      ["addition", c]
    end
  end
  
  def subtraction
    a = rand(10)
    b = rand(10)
    c = a - b
    puts "#{a}-#{b}=x"
    print "x="
    answer = gets.chomp!.to_i
    if c == answer
      ["subtraction", true]
    else
      ["subtraction", c]
    end
  end
  
  def multiplication
    a = rand(10)
    b = rand(10)
    c = a * b
    puts "#{a}X#{b}=x"
    print "x="
    answer = gets.chomp!.to_i
    if c == answer
      ["multiplication", true]
    else
      ["multiplication", c]
    end
  end

  def division
    b = rand(10)
    c = rand(9) + 1
    a = b * c
    puts "#{a}/#{b}=x"
    print "x="
    answer = gets.chomp!.to_i
    if c == answer
      ["division", true]
    else
      ["division", c]
    end
  end
  
  def squares
    a = rand(10)
    b = a**2
    puts "#{a}^2=x"
    print "x="
    answer = gets.chomp!.to_i
    if b == answer
      ["squares", true]
    else
      ["squares", b]
    end
  end

  def roots
    b = rand(10)
    a = b**2
    puts "√#{a}=x"
    print "x="
    answer = gets.chomp!.to_i
    if b == answer
      ["roots", true]
    else
      ["roots", b]
    end
  end

  def exponents
    a = rand(5)
    b = rand(3..5)
    c = a**b
    puts "#{a}^#{b}=x"
    print "x="
    answer = gets.chomp!.to_i
    if c == answer
      ["exponents", true]
    else
      ["exponents", c]
    end
  end

  def logarithms
    a = rand(2..5)
    c = rand(5)
    b = a**c
    puts "#{a}^x=#{b}"
    print "x="
    answer = gets.chomp!.to_i
    if c == answer
      ["logarithms", true]
    else
      ["logarithms", c]
    end
  end
  
  def ask
    case @diff
    when "easy"
      cattegories = ["addition", "subtraction", "multiplication", "division"]
    when "medium"
      cattegories = ["squares", "roots"]
    when "hard"
      cattegories = ["exponents", "logarithms"]
    end
    
    self.send(cattegories[rand(cattegories.length)])
  end
end

class Quizlet
  def run(questions)
    score = 0
    wrong = []
    questions[:easy]   ||= 0
    questions[:medium] ||= 0
    questions[:hard]   ||= 0
    
    puts "Welcome to QUIZLET!"
    
    questions.keys.each do |k|
      questions[k].times do
        a = Question.new(k.to_s)
        result = a.ask
        if result[1] == true
          puts "Correct!"
          score += 1
        else
          puts "Sorry, the answer was #{result[1]}."
          wrong += [result[0]]
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
      puts "Not bad, but maybe work on your #{most_common_value(wrong)}. (#{wrong.count(most_common_value(wrong))} wrong)"
    when percent > 60
      puts "Could use same work? Maybe take a look at your #{most_common_value(wrong)}. (#{wrong.count(most_common_value(wrong))} wrong)"
    else
      puts "Maybe try again? Also, you should focus on your #{most_common_value(wrong)}. (#{wrong.count(most_common_value(wrong))} wrong)"
    end
  end
end

q = Quizlet.new
q.run({easy:5, medium:5, hard:5})