require_relative "game_judge"

class Board

  attr_accessor :board, :judge
  ROWS = 6
  COLS = 7

  def initialize
    @movements = []
    @board = create_board
    @judge = GameJudge.new(@board)
  end

  def create_board
    board = []
    COLS.times do 
      board << Array.new(ROWS)
    end
    board
  end

  def max_turns
    ROWS * COLS
  end

  def get_max_cols
    COLS
  end

  def get_max_rows
    ROWS
  end

  def won?
    return @judge.game_over?
  end

  def fill_column(col, color)
    colors = { r: "R", b: "B" }
    #colors = { b: "⚫", r: "🔴" }
    raise "Invalid move, pick a column between A and G" if col > COLS

    free_slots = @board[col].count { |e| e.nil? }

    raise "Invalid move, column #{("A".."G").map(&:to_s)[col]} has no empty slots" if free_slots == 0

    blank_slot = ROWS - free_slots
    @board[col][blank_slot] = get_color_text(colors[color], color)
    @movements << { color: color, col: col, row: blank_slot }
    puts self
    puts
    puts "#{color.to_s.upcase} placed at #{("A".."G").map(&:to_s)[col]}, #{blank_slot + 1}"
  end

  def undo_last_movement
    last_movement = @movements.pop
    @board[last_movement[:col]][last_movement[:row]] = nil
    puts self
    puts
    puts "#{last_movement[:color].to_s.upcase} removed at #{("A".."G").map(&:to_s)[last_movement[:col]]}, #{last_movement[:row] + 1}"
  end
  
  def get_color_text(text, color)
    color_codes = { r: 31 }
    if color_codes[color].nil?
      return text
    else
      return "\e[#{color_codes[color]}m#{text}\e[0m"
    end
  end
  
  def to_s
    Gem.win_platform? ? (system "cls") : (system "clear")
    value = "   "
    value += "===" * 7
    value += "\n"
    value += "      Connect 4 game   \n   "
    value += "===" * 7
    value += "\n"
    value += "   Instructions:       \n"
    value += "   1. Select a letter between A and G  \n"
    value += "   2. You can UNDO before ending your turn but only once per turn\n"
    value += "   3. To exit you can type Q during your turn \n"
    value += "   4. To win a player must have 4 tokens in a row/col/diagonal\n"
    value += "   5. Enjoy the game! \n   "
    value += "---" * 7
    value += "\n"
    value += "   Remaining turns: #{max_turns - @board.flatten.reject(&:nil?).count}\n   "
    value += "---" * 7
    value += "\n"

    (ROWS - 1).downto(0) do |level|
      value += " #{level+1} "
      @board.each do |row|
        token = row[level]
        value += token.nil? ? "| |" : "|#{token}|"
      end
      value += "\n"
    end

    value += "   "
    value += "==="*7 + "\n"
    value += "   "
    value += ("A".."G").map { |v| "|#{v}|" }.join
    value
  end
end
