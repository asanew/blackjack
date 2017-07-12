require_relative 'card'
require_relative 'deck'
require_relative 'gamer'
require_relative 'dealer'

class Program
  attr_reader :bank, :deck, :gamers, :turn

  def initialize
    @deck = Deck.new
    @gamers = []
    @gamers << Gamer.new
    @gamers << Dealer.new
    @bank = 0
  end

  def start_round
    @gamers.each do |gamer|
      @bank += gamer.bet
      2.times { gamer.get_card(@deck) }
    end
    @turn = 1
  end

  def end_round
    puts @gamers[1].show_cards
    gamer_points = @gamers[0].calc_points
    dealer_points = @gamers[1].calc_points
    gamer_gain = 0
    if gamer_points <=21
      if gamer_points > dealer_points
        gamer_gain = @bank
        puts 'Congratulations! You win!'
      elsif gamer_points == dealer_points
        gamer_gain = @bank / 2
        puts "It's a draw"
      else
        puts 'You lose'
      end
    else
      puts 'You lose'
    end
    @gamers[0].gain(gamer_gain)
    @gamers[1].gain(@bank - gamer_gain)
    @bank = 0
    @gamers.each { |gamer| gamer.drop_cards }
  end

  def hello
    puts 'Welcome to RubyJack game'
    puts "We has new deck: #{@deck.cards*' '}"
    puts 'Gamer and Dealer'
    puts "And $#{@bank} in bank"
  end

  def error_message
    puts 'Incorrect input, fix please'
  end

  def actions
    actions = []
    actions = [ 'pass', 'card', 'show' ] if @turn == 1
    actions = [ 'card', 'show' ] if @turn > 1 && @gamers[0].cards.length == 2
    return actions
  end

  def status
    gamers.each { |gamer| puts gamer.to_s }
    puts "$#{@bank} in bank"
  end

  def dealer_think
    @gamers[1].think(@deck)
  end
  
  def choice_pass
    @turn += 1
    dealer_think
  end

  def choice_card
    @gamers[0].get_card(@deck)
    @turn += 1
    dealer_think
  end

  def user_play
    start_round
    loop do
      status
      act = actions
      if act.empty?
        end_round
        break
      end
      puts "Make a choice: #{act.join(' | ')}"
      user_input = gets.chomp.downcase
      case user_input
      when 'pass'
        choice_pass
      when 'card'
        choice_card
      when 'show'
        end_round
        break
      else
        error_message
      end
    end
  end

  def validate!
    if @deck.cards.length < 6
      raise 'Not enough cards in a deck'
    elsif @gamers[0].wallet == 0
      raise 'Sorry, you a lost all your money'
    elsif @gamers[1].wallet == 0
      raise 'Congratulations, you are winner!'
    end
  end
  
  def menu
    hello
    loop do
      puts 'Make a choice: start or exit'
      user_input = gets.chomp.downcase
      case user_input
      when 'start'
        user_play
        validate!
      when 'exit'
        raise 'User exit'
      else
        error_message
      end
    end
  end
end

prog = Program.new
loop do
  begin
    begin
      prog.menu
    rescue => e
      puts e.message
      prog = Program.new
      puts 'Game is over, begin new game? (y/n)'
      user_input = gets.chomp.downcase
      if user_input == 'n'
        raise 'User end game'
      end
    end
  rescue
    break
  end
end
