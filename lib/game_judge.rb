class GameJudge
  attr_accessor :board

  def initialize(board)
    @board = board
    @max_turns = Board::COLS * Board::ROWS
  end

  def game_over?
   find_winner || tie?
  end

  def tie?
    !can_continue_playing?
  end

  def find_winner
    [get_color_text("R", :r),get_color_text("B", :b)].each do |p|
      win_pattern = "#{p}"* 4
      return p if get_board_pattern.any? { |pat| pat.include?(win_pattern) }
    end
    false
  end

  protected

  def get_board_pattern
    board_patterns = get_col_patterns
    board_patterns.concat(get_row_patterns)
    board_patterns.concat(get_diagonal_patterns)
    board_patterns
  end

  def get_col_patterns(board = @board)
    get_col_members(board).map { |a| a.join("") }
  end


  def get_color_text(text, color)
    color_codes = { r: 31 }
    if color_codes[color].nil?
      return text
    else
      return "\e[#{color_codes[color]}m#{text}\e[0m"
    end
  end

  def get_col_members(board = @board)
    patterns = board.map do |col|
      col.map{|a| a.nil? ? 'x' : a} 
    end
  end

  def get_row_patterns
    patterns = get_col_patterns(@board.safe_transpose)
  end

  def get_diagonals(patterns)
    patterns.transpose.flatten.group_by.with_index { |_, k| k.divmod(patterns.size).inject(:+) }.values.select { |a| a if a.length >= 4 }
  end

  def get_diagonal_patterns
    patterns = get_diagonals(@board).map { |a| a.map{|v| v.nil? ? 'x' : v}.join("") }
    patterns.concat(get_diagonals(@board.reverse).map { |a| a.map{|v| v.nil? ? 'x' : v}.join("") })
  end

  def can_continue_playing?
    [get_color_text("R", :r),get_color_text("B", :b)].each do |p|
      remaining_turns = @max_turns - get_col_members.flatten.reject { |v| v == 'x' }.count 
      possible_patterns = [p,p,p,p,'x','x','x','x'].permutation(4).to_a.uniq.map{|v| v.join("") }
      possible_patterns.each do |pattern|
        return true if get_board_pattern.any? { |a| a.include?(pattern) }
      end
    end

    false
  end

end
