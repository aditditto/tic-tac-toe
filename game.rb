require './board.rb'

class Game
  def initialize
    puts 'Please input a symbol for player 1.'
    @player1 = ask_symbol
    puts 'Please input a symbol for player 2.'
    @player2 = ask_symbol
    @play_board = Board.new
    puts %q(Welcome to Tic-Tac-Toe.
      Below is the grid positions you can input.
      1 2 3
      4 5 6
      7 8 9
      )
      play_session
  end

  def play_session
    current_symbol = @player1
    until full? || won?
      print "Player #{current_symbol == @player1 ? '1' : '2'}'s turn, input a position: "
      player_pos = gets.chomp.to_i - 1
      until @play_board.empty?(player_pos)
        print 'Whoops, that position is invalid! Input a valid position:'
        player_pos = gets.chomp.to_i - 1
      end
      # player_pos -= 1
      # binding.pry
      puts player_pos
      @play_board.player_input(current_symbol, player_pos)
      @play_board.print_board
      current_symbol = current_symbol == @player1 ? @player2 : @player1
    end
    puts 'It\'s a draw...' if full? && !won?
    if won?
      puts current_symbol == @player2 ? 'Player 1 won!' : 'Player 2 won!'
    end
  end

  private

  def ask_symbol
    x = gets.chomp
    until x != '-' && x.length == 1
      puts 'Please input a valid symbol. (single character and not -)'
      x = gets.chomp
    end
    x
  end

  def row_won?
    (0..2).each do |row|
      return true if @play_board.grid[row].uniq.length == 1 && @play_board.grid[row].uniq[0] != '-'
    end
    false
  end

  def column_won?
    (0..2).each do |column|
      column_digits = [
        @play_board.grid[0][column],
        @play_board.grid[1][column],
        @play_board.grid[2][column]
      ]
      return true if column_digits.uniq.length == 1 && column_digits.uniq[0] != '-'
    end
    false
  end

  def cross_won?
    forward_slash = [
      @play_board.grid[0][2],
      @play_board.grid[1][1],
      @play_board.grid[2][0]
    ]
    backward_slash = [
      @play_board.grid[0][0],
      @play_board.grid[1][1],
      @play_board.grid[2][2]
    ]
    (forward_slash.uniq.length == 1 && forward_slash.uniq[0] != '-') ||
      (backward_slash.uniq.length == 1 && backward_slash.uniq[0] != '-')
  end

  def won?
    column_won? || cross_won? || row_won?
  end

  def full?
    @play_board.grid.each do |row|
      return false if row.include?('-')
    end
    true
  end
end