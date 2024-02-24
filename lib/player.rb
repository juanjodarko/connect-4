class Player
  attr_reader :color
  VALID_KEYS = %w{A B C D E F G Q U}

  def initialize(color)
    @color = color
  end
  
  def turn(board)
    posible_range = board.get_max_cols
    begin
      board.fill_column(get_pos(posible_range), @color)
    rescue Exception => e
      puts e
      retry
    end
  end

  def exit_game
    puts "Do you really want to exit? (y/N)"
    res = gets.chomp.upcase
    exit! if res == "Y"
  end

end
