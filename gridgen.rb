#!/usr/bin/env ruby  -w

# This program generates a 5x5 grid with random letters
# And reads a dictionary file to match those letters
# in case of match it prints the word that matched

class GridGen
  
  # creates a new grid with any dimension
  def initialize(width, height)
    @w = width
    @h = height
    @time = Time.now
  end 

  # Removed because it was slow opening the file everytime
  # 
  # 
  # receives the word and searches for it in the dictionary
  # it prints the word when there is a match
  # def read_dictionary_for(word)
  #    File.open('dictionary.txt').each do |line|
  #      line.split("\n").each do |dword|
  #        # if the word matches print it
  #        if dword == word
  #          p "'#{word}' matches"
  #        end
  #       end
  #    end 
  # end
   
  def read_dictionary
    # p 'Matching Words'
    
    num_words = 0
    File.open('dictionary.txt').each do |line|
      line.split("\n").each do |word|
        @words.select{ |w| 
          if w == word
            # p w
            num_words +=1
          end
        }
      end
    end
    
    # writes the results at the end of the file
    File.open('results.txt', 'a+') do |f|
      f.write("Time: #{Time.now - @time} seconds \nWords found: #{num_words}\nGrid Size: #{@w}x#{@h}\n\n")
    end
    # p "It took #{Time.now - @time} seconds"
    # p "Number of words found: #{num_words}"
  end
  
  
  def generate_grid
    # creates a two dimensional grid with a letter in each position
    @grid =  Array.new(@w) { Array.new(@h) {(0...1).map{65.+(rand(25)).chr}.join}}
    
    # prints the array for reference
    # @grid.each do |line|
    #   p line
    # end
    
    # @grid.each_with_index do |x, xi|
    #   x.each_with_index do |y, yi|
    #     puts "element [#{xi}, #{yi}] is #{y}"
    #   end
    # end
    
  end

  def grid_word_generator
    # number of columns
    x = @w 
    # number of lines
    y = @h
    # horizontal word
    h_word = Array.new(2, Hash.new)
    # vertical word
    v_word = Array.new(2, Hash.new)
    
    # generates words per line
    @words = []
    for j in 0..(y-1) do
      word = ""
      for i in 0..(x-1) do
        word += @grid[i][j]
        h_word[j] = word
        # read_dictionary_for(word)
        @words << word
      end
    end
    
    # generates words per column
    for i in 0..(x-1) do
      word = ""
      for j in 0..(y-1) do
        word += @grid[i][j]
        v_word[x] = word
        # read_dictionary_for(word)
        @words << word
      end
    end
    
  end

end

m = GridGen.new(5,5)
m.generate_grid
m.grid_word_generator
m.read_dictionary