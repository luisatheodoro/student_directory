@students = []

def print_header
  puts "The students of Makers Academy"
  puts "-------------"
end

def print_students_list
  @students.each_with_index do |student, index| 
    puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
  end
end 

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  name = gets.chomp
  while !name.empty? do
    @students << {name: name, cohort: :november}
    puts "Now we have #{@students.count} students"
    name = gets.chomp
  end
  students
end

def print_footer
  puts "Overall, we have #{@students.count} great students"
end

def check_if_input_was_given_and_is_correct(input, type_of_data)
  until !input.empty?
    puts "You left the field blank, write the #{type_of_data} again"
    input = gets.chomp
  end
  while true
    puts "Is #{input} correct?(y/n)"
    y_n = gets.chomp
    if y_n == "n"
      puts "write the #{type_of_data} again"
      input = gets.chomp
    elsif y_n == "y"
      break
    else
      puts "Type only y or n"
    end
  end
  return input
end

def edit_student_detail
  @students.each do |s|
    print_students_list 
    puts "Would you like to edit the name or the cohort?"
    input = gets.chomp
    while true
      p input
      if input != "name" && input != "cohort"
        puts "This option is not valid, choose name or cohort"
        input = gets.chomp.downcase
      else 
        puts "Please write the #{input} again"
        new_input = gets.chomp.downcase
        s["#{input}".to_sym] = new_input
        break
      end
    end
  end
end

print_header
print_students_list
print_footer
