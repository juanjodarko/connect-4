require_relative "lib/game.rb"
require_relative "lib/utils.rb"

if $PROGRAM_NAME == __FILE__
  Gem.win_platform? ? (system "cls") : (system "clear")
  puts "Starting Connect 4"
  puts "Select the Game mode:"
  puts "1) Human vs CPU"
  puts "2) Human vs Human"
  puts "3) Exit game"
  option = gets.chomp.to_i
  Gem.win_platform? ? (system "cls") : (system "clear")

  case option
  when 1
    # Start Game with cpu and human
    player_red = HumanPlayer.new(:r)
    player_black = CpuPlayer.new(:b)
    game = Game.new( players: { red: player_red, black: player_black })
    game.init_play
  when 2
    # Start game with h v h
    player_red = HumanPlayer.new(:r)
    player_black = HumanPlayer.new(:b)
    game = Game.new( players: { red: player_red, black: player_black })
    game.init_play
  when 3
    puts "Thanks for playing!"
    exit!
  else
    puts "Not a valid option"
  end
end
