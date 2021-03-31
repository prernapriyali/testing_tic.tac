#!/usr/bin/env ruby

require_relative '../lib/player'
require_relative '../lib/helper'

class TicTacToe
  def initialize
    @_board = [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
    @name = []
    @helper = Helpers.new
    @game_over = false
    @counter = 0
  end

  def start
    puts 'Welcome to TIC-TAC-TOE'
    puts ''
    sleep 1
    puts 'A simple game developed by Ralph and Prerna'
    puts ''
    sleep 1
  end

  def instructions
    sleep 1
    puts "You will have a 3x3 board and player 1 will have the first turn\n"
    puts "When it's your turn enter the number of the square that you want to play (between 1 and 9)"
    puts "Don't choose squares that are already occupied\n\n"
    puts '    -------------'
    puts '    | 1 | 2 | 3 |'
    puts '    -------------'
    puts '    | 4 | 5 | 6 |'
    puts '    -------------'
    puts '    | 7 | 8 | 9 |'
    puts '    -------------'
    puts "\nThe winner is the first one to form a line with 3 symbols vertically, horizontally or diagonally\n\n"
    puts 'Press Enter to continue'
    gets.chomp
    system 'clear'
  end

  def display_board
    puts "  #{@_board[0]}, #{@_board[1]}, #{@_board[2]}"
    puts separator = '-----------'
    puts "  #{@_board[3]}, #{@_board[4]}, #{@_board[5]}"
    puts separator
    puts "  #{@_board[6]}, #{@_board[7]}, #{@_board[8]}"
    puts ''
  end

  def player_move(user_input)
    user_input.to_i - 1
  end

  def move_on_board(index)
    @_board[index] = @player.token
  end

  def turn_count
    if @_board.include?('X')
      @counter += 1
    elsif @_board.include?('O')
      @counter += 1
    else
      @counter
    end
    @counter
  end

  def turn
    @player = @player == @name[0] ? @name[1] : @name[0]
    puts "#{@player.name}, choose a spot between 1-9"
    player_play = gets.strip.to_i
    until player_play.positive?
      puts 'Please enter a valid move'
      player_play = gets.strip.to_i
    end
    until @helper.valid_move?(@_board, player_move(player_play))
      puts "#{@player.name}, Place is already taken.Choose another number between 1-9"
      player_play = gets.strip.to_i
    end
    move_on_board(player_move(player_play))
    display_board
    if @helper.won?(@_board)
      puts "Congratulations #{@player.name} you won!!!"
      @game_over = true
    elsif @helper.draw?(turn_count)
      puts 'It is a Draw!!!'
      @game_over = true
    end
  end

  def names_of_users
    tokens = %w[X O]

    2.times do |item|
      puts 'Please enter names of players: '
      player_name = gets.chomp.strip
      puts ''

      while player_name.empty?
        puts 'Please enter a valid name'
        player_name = gets.strip.to_s
        break unless player_name.empty?
      end
      @name << Player.new(player_name, tokens[item])
    end

    until @name[1].name != @name[0].name
      puts "Your name should be different than #{@name[0].name}:"
      player2 = gets.strip.to_s
      @name[1] = Player.new(player2, 'O')
    end
    sleep 1
  end

  def greeting
    puts "Today our players are: #{@name[0].name} and #{@name[1].name}"
    puts ''
    sleep 1
    puts "#{@name[0].name} is going to play with 'X' symbol."
    sleep 1
    puts ''
    puts "#{@name[1].name} is going to play with 'O'symbol"
    sleep 1
  end

  def execute
    start
    instructions
    system('clear')
    names_of_users
    greeting
    puts ''
    turn until @game_over
  end
end

play_game = TicTacToe.new
play_game.execute
sleep 1
puts '**I’m tired of Tic Tac Toes… -_- **'
