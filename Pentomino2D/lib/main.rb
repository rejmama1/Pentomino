require 'lib/problem/pentomino'

a = Time.new

if ARGV.size == 1
  problem = Pentomino.new(ARGV[0])
else
  problem = Pentomino.new("lib/sample1.txt")
end

puts "Height: #{problem.height}"
puts "Width: #{problem.width}"
puts "------------------------------------------------"

if not problem.possible_to_find_solution?(problem.pieces,problem.width*problem.height)
  fail("Nema zadne reseni.")
 
end

for i in 0..problem.pieces.size - 1
  problem.pieces[i].normalize
    
end

for i in 0..problem.pieces.size - 1
  problem.pieces[i].to_s
  puts
    
end
puts "--------------------------------------------------------"

solution=false

puts "Starting at: #{a}"
puts

for i in 0..problem.pieces.size-1
 
  @used=Array.new(problem.pieces.size)
  @used.fill(false)
  @used[i] = true
  if problem.solve(i,0,0,@used)
    solution = true
    break
  end
end


if solution
  puts "Nalezeno reseni:"
  problem.show_board
else
  puts "Nenalezeno reseni"
end
puts 

b=Time.new
puts "Ends at: #{b}"
puts "Total time: #{b-a} s"

