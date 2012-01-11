#Creates user-defined pieces

class Piece
  attr_reader :shape,:width, :height
  def initialize
    @shape = Array.new
    @width = 0
    @height = 0
  end
  
  #Adds custom shape
  def add_line(array)
    @shape.push(array)
    @height+=1
    if array.size > @width
      @width = array.size
    end
  end
  
  
  #Normalizes given shape; adds zeros to create bounded rectangle
  def normalize
    for i in 0..@height-1
      if @shape[i].size < @width
        for j in 0..@width - @shape[i].size - 1
          @shape[i].push(0)
        end
      end
    end
  end
  
  #Orotuje kosticku o 90 stupnu doprava; 1. radek = 1 sloupek od spoda
  def rotate
    tmp_piece=Piece.new
    for i in 0..@width-1
      shape_line=Array.new
      
      (@height-1).downto(0) { |j|
        shape_line.push(@shape[j][i])
      }
      
    
      tmp_piece.add_line(shape_line)
    end
    return tmp_piece
  end
  
  #Creates mirror of the shape
  def get_mirror
    tmp_piece=Piece.new
    for i in 0..@height-1
      shape_line=Array.new
      
      (@width-1).downto(0) { |j|
        shape_line.push(@shape[i][j])
      }
      
    
      tmp_piece.add_line(shape_line)
    end
    return tmp_piece
  end
  
  #Evaluates number of pieces
  def consist_of
    pieces=0
    for i in 0..@height - 1
      for j in 0..@shape[i].size - 1
        if @shape[i][j]!=0
          pieces+=1
        end
      end
    end
    return pieces
  end
  
  
  def to_s
    for i in 0..@height - 1
      for j in 0..@shape[i].size - 1
        print @shape[i][j].to_s + " "
      end
      puts
    end
  end
end
