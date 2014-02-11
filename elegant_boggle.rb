Words = { 'the' => true, 'then' => true, 'their' => true } # our dictionary
Found = {} # words we've found

num = 4 # extendable to any size board
total = num ** 2 # letters on the board
Prev = Array.new(num) { [false] * num  } # cell's we've visited
Board = Array.new(num) { [0] * num  } 
# letters come from the command line 'ARGV'
(0...total).each { |i| Board[i/num][i%num] = ARGV[i]} # num X num array of strings

# recursive DFS
Directions = [ [-1,-1], [-1,0], [-1,1], [0,-1], [0,1], [1,-1], [1,0], [1,1] ]

def solve(x, y, substring)
  Prev[x][y]=true # 'Mark our turf' ;)

  word = substring + Board[x][y]
  Found[word]=true if Words[word] # record the new word found 
  # hashes give quick lookup -> elegant

  Directions.each do |dx, dy|
    next unless (0...Board.count)===(x+dx) # syntax sugar for 0 <= x+dx && x+dx < num
    next unless (0...Board.count)===(y+dy)
    next if Prev[x+dx][y+dy] # we've been here before
    solve(x+dx,y+dy,word)
  end
  Prev[x][y] = false # this path is done
end

# start search from each cell
(0...total).each { |i| solve(i/num, i%num, "") } # one line boggle! elegant or what?!

# show all found words
puts Found.keys.inspect