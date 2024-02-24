class HumanPlayer < Player
  def get_pos(range)
    value = -1
    until ("A".."G").include?(value)
      puts "Please select a column letter between A and G, to Exit use Q"
      value = gets.chomp.strip.upcase
      if value == "Q"
        exit_game
      end
      raise "Invalid move, pick a column between A and G" unless VALID_KEYS.include?(value)

    end
    ("A".."G").map(&:to_s).index value
  end

  def end_phase(board)
    value = -1
    puts "Do you want UNDO? (y/N)"
    value = gets.chomp.upcase
    if value == "Y"
      board.undo_last_movement
      self.turn(board)
    end
  end

end
