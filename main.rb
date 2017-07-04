require_relative 'card'
require_relative 'deck'
require_relative 'gamer'

class Program
  attr_reader :bank, :deck, :gamer, :dealer

  def initialize
    @deck = Deck.new
    @gamer = Gamer.new
    @bank = 0
  end

  def hello
    puts 'Welcome to RubyJack game'
    puts "We has new deck: #{@deck.cards*" "}"
    puts "Gamer and Dealer"
    puts "And $#{@bank} in bank"
  end

  def menu
  end
end

prog = Program.new
prog.hello
prog.menu
