# Pentomino problem

require 'lib/problem/piece'
require 'lib/problem/coordinate'

class Pentomino
  attr_reader :height,:width,:pieces
  
  #Load problem from file
  #If file is in wrong format, program starts solving normal pentomino
  #Otherwise solves problme in file
  def initialize(file)
   
    begin
      @f = File.open(file,"r")
      load_game_board
      load_pieces
    rescue Exception
      puts "Chyba: #{$!}"
      load_standard_game
    end
  end
  
  
  #Tries to put new piece on board
  #Tries all rotations and rotations of its mirror
  def solve(piece, row, col, used)
    tmp = @pieces[piece] 
    for i in 0..7
      remove_piece(piece+1)
      used[piece] = false
     
      if i == 4
         tmp = tmp.get_mirror
      end
      tmp = tmp.rotate
     
      put = put_piece(tmp,piece,row,col)
      
      if put
        used[piece] = true
        if solution?
          return true
        end
#        show_board
#        puts
         
        for j in 0..used.size-1
            c = find_free_place
            if not used[j] 
              if solve(j,c.row,c.col,used)
                 return true
              end
          end
          
        end
      end
    end
    remove_piece(piece + 1)
    used[piece] = false
    
  end
  
  #Checks if board has enough slot for pieces
  def possible_to_find_solution?(pieces,board)
    for i in 0..pieces.size-1
      board-=pieces[i].consist_of
    end
    return board == 0
  end
  
  #Display actual board state
  def show_board
    for i in 0..@board.size - 1
      for j in 0..@board[i].size - 1
        print @board[i][j].to_s + " "
      end
      puts
    end
  end
  
  #Checks if actual board is possible result
  def solution?
    for i in 0..@board.size-1
      for j in 0..@board[i].size-1
        if @board[i][j]==0
          return false
        end
      end
    end
    return true
  end
  
  
  #Tries to put piece in given rotatation to given coordinates
  def put_piece(piece, index, row, col)
    tmp_row = row
    tmp_col = col
    for i in 0..piece.height - 1
      if tmp_row > @height - 1
        remove_piece(index+1)
        return false
      end
      
      for j in 0..piece.width - 1
         if tmp_col > @width -1
          remove_piece(index+1)
          return false
        end
        
        if piece.shape[i][j] != 0 && @board[tmp_row][tmp_col] ==0
          @board[tmp_row][tmp_col] = piece.shape[i][j]
        else if piece.shape[i][j] != 0 && @board[tmp_row][tmp_col] !=0
            remove_piece(index+1)
            return false
          end
        end
        tmp_col = tmp_col + 1
       
      end
      tmp_row+= 1
      tmp_col= col
      
    end
    return true
  end
  
  #Finds first free slot in the board. First left-right, than top-bottom
  def find_free_place
    for i in 0..@board.size - 1
      for j in 0..@board[i].size - 1
        if @board[i][j]== 0
          return Coordinate.new(i, j)
        end
      end
    end 
  end
  
  
  #Removes piece from board
  def remove_piece(index)
   
    for i in 0..@board.size - 1
      for j in 0..@board[i].size - 1
        if @board[i][j]== index
          @board[i][j] = 0
        end
      end
    end 
  end
  
  
  
  #Load board from file
  def load_game_board
    line = @f.gets
    tokens = line.scan(/[-+]?\d*\.?\d+/)
    if tokens.size != 2
      puts "Spatny format vstupu (hraci plocha). Bude automaticky vygenerovana."
      @width = Integer(rand(30))
      @height = 150 / @width
      puts "Byla vygenerovana hraci plocha #{@width} x #{@height}"
      return
    end
    
    @width = Integer(tokens[0])
    @height = Integer(tokens[1])
    
    @board = Array.new(@height) { Array.new(@width)}
    empty_board(@board)
    
  end
  
  #Erase playing board
  def empty_board(board)
    for i in 0..board.size - 1
      for j in 0..board[i].size - 1
        board[i][j] = 0
      end
    end
  end
  
  #Loads standard game
  def load_standard_game
    @width = 5
    @height = 4
    
    @board = Array.new(@height) { Array.new(@width)}
    
    empty_board(@board)
    
    @pieces = Array.new(5)
    
    #L-3
    piece = Piece.new
    piece.add_line([1,1])
    piece.add_line([1])
    piece.add_line([1])
    @pieces[0] = piece
   
    
    #L
    piece = Piece.new
    piece.add_line([2])
    piece.add_line([2])
    piece.add_line([2])
    piece.add_line([2,2])
    @pieces[1] = piece
   
      
    
    #U
    piece = Piece.new
    piece.add_line([3,0,3])
    piece.add_line([3,3,3])
    @pieces[2] = piece
    
    
    #V
    piece = Piece.new
    piece.add_line([4])
    piece.add_line([4])
    piece.add_line([4,4,4])
    @pieces[3] = piece
    
    #1
    piece = Piece.new
    piece.add_line([5])
    @pieces[4] = piece
    
  
    
  end
  
  #Load user-defined pieces from file
  def load_pieces
    @f.gets
    line = @f.gets
    tokens = line.scan(/[-+]?\d*\.?\d+/)
    if tokens.size != 1
      puts "Spatny format vstupu. Ocekavano cislo s poctem definovanych kosticek.
      Bude vyresena zakladni verze pentomina."
      load_standard_game
      return
    end
    
    @f.gets
    @pieces = Array.new(Integer(tokens[0]))
    @pieces.fill(nil)
       
    for i in 0..@pieces.size - 1
      line = @f.gets
      tokens = line.scan(/[-+]?\d*\.?\d+/)
      piece = Piece.new
      
      while tokens.size != 0
        shape_line = Array.new
        value = 0
        for j in 0..tokens.size - 1
           
          piece_index=Integer(tokens[j])
        
          #Kontroluje zda v zadani kosticky nejsou ruzna cisla
          if piece_index!=0 && value == 0
            value = piece_index
          end
           
          if(value!=0 && piece_index != value && piece_index != 0)
            raise Exception, "Spatny vstup. Chyba v zadani kosticek."
          end
          
           
          shape_line.push(Integer(tokens[j]))
           
        end
        piece.add_line(shape_line)
        line = @f.gets
        if(line == nil)
          break
        end
        tokens = line.scan(/[-+]?\d*\.?\d+/)
        
      end
      
      if @pieces[value - 1] == nil
        @pieces[value - 1] = piece
      else
        raise Exception, "Duplikovane zadani kosticky."
      end
    end
   
  end
  
  
  
  
end
