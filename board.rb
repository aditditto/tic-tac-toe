class Board
  attr_reader :grid
  def initialize
    @grid = [
      ['-', '-', '-'],
      ['-', '-', '-'],
      ['-', '-', '-']
    ]
  end

  def print_board
    @grid.each do |line|
      line.each do |digit|
        print digit.to_s
        print ' '
      end
      puts ''
    end
  end

  def player_input(symbol, pos)
    write_in(symbol, pos) if empty?(pos)
  end

  def empty?(pos)
    row = coord(pos)[:row]
    column = coord(pos)[:column]
    @grid[row][column] == '-'
  end

  private

  def coord(pos)
    row = (pos / 3.0).floor.to_i
    { row: row, column: pos - row * 3 }
  end

  def write_in(symbol, pos)
    row = coord(pos)[:row]
    column = coord(pos)[:column]
    @grid[row][column] = symbol
  end
end
