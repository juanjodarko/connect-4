require_relative "board"
require_relative "player"
require_relative "human_player"
require_relative "cpu_player"

class Game
  attr_reader :players, :board

  def initialize(attrs={})
    puts "Setting up Game... "
    @players = attrs[:players]
    @board = Board.new
    puts "Lets start"
  end
  
  def init_play
    turns = 0
    max_turns = @board.max_turns

    puts @board
    until @board.won? || turns >= max_turns
      turns += 1
      @current_player = (turns % 2 == 0) ? :black : :red
      puts "*"*80
      puts "#{@current_player} turn"
      puts "*"*80
      
      @players[@current_player].turn(@board)
      @players[@current_player].end_phase(@board)

    end
    puts "*"*80
    puts "END GAME #{@board.won?} WON "
    puts "*"*80
  end

end
