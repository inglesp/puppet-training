# examples/get_birthday_2.rb
def get_response(question, lower_bound, upper_bound)
  while true
    puts question

    value = gets.chomp.to_i

    if value < lower_bound || value > upper_bound
      puts "Invalid response"
    else
      break
    end
  end

  value
end

year = get_response("What year were you born in?", 1900, 2015)
month = get_response("What month were you born in?", 1, 12)
day = get_response("What day were you born on?", 1, 31)

puts "You were born on #{year}-#{month}-#{day}"
