require 'csv'
@students = []

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to a cvs file"
  puts "4. Load the list from a csv file"
  puts "5. Edit student detail"
  puts "9. Exit"
end

def show_students
  print_header
  print_students_list
  print_footer
end

def process(selection)
  case selection
    when "1"
      input_students
      puts ">>Students input was sucessfull"
    when "2"
      show_students
      puts ">>Students printed to screen"
    when "3"
      save_students
      puts ">>Students saved to file"
    when "4"
      load_students
      puts ">>Students loaded"
    when "5"
      edit_student_detail
      puts ">>Student detail edited"
    when "9"
      exit
    else
      puts "I don't know what you mean, try again"
  end
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def push_student_data_inside_array(name, cohort)
  @students << {name: name, cohort: cohort.to_sym}
end

def save_students
  CSV.open("#{input_file_name}.csv", "w") do |csv|
    @students.each do |student|
      csv << [student[:name], student[:cohort]]
    end
  end
end

def load_students
  CSV.foreach("#{input_file_name}.csv", "r") do |student|
      name, cohort = student[0], student[1]
      push_student_data_inside_array(name, cohort)
  end
end

def try_load_students()
  filename = ARGV.first
  return if filename.nil? 
  if CSV.exists?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else 
    puts "Sorry, #{filename} doesn't exist."
    exit 
  end
end

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
  puts "Enter the name of the students"
  puts "To finish, just hit return twice"
  name = STDIN.gets.chomp
  puts "What is the cohort?"
  cohort = STDIN.gets.chomp
  while !name.empty? do
    push_student_data_inside_array(name, cohort)
    puts "Now we have #{@students.count} students"
    puts "name:"
    name = STDIN.gets.chomp
    puts "cohort:"
    cohort = STDIN.gets.chomp
  end
  @students
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

interactive_menu
