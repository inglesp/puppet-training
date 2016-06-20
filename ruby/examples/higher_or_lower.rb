# examples/higher_or_lower.rb
n = rand(1..100)

puts "I'm thinking of a number between 1 and 100."

puts "Make a guess!"
guess = gets.chomp.to_i

while guess != n
  if guess < n
    puts "Too low."
  else
    puts "Too high."
  end

  puts "Make a guess!"
  guess = gets.chomp.to_i
end

puts "Yes, my number was #{n}."
