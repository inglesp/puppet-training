# examples/get_birthday.rb

while true
  puts "What year were you born in?"

  year = gets.chomp.to_i

  if year < 1900 || year > 2015
    puts "Invalid response"
  else
    break
  end
end

while true
  puts "What month were you born in?"

  month = gets.chomp.to_i

  if month < 1 || month > 12
    puts "Invalid response"
  else
    break
  end
end

while true
  puts "What day were you born on?"

  day = gets.chomp.to_i

  if day < 1 || day > 31
    puts "Invalid response"
  else
    break
  end
end

puts "You were born on #{year}-#{month}-#{day}"
