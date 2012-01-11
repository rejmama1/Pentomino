#Represents coordinates
#First free slot to place a piece

class Coordinate
  attr_reader :row,:col
  
  def initialize(row,col)
    @row = row
    @col = col
  end
end
