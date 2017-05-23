require_relative 'card'

class Deck
  attr_reader :cards
  
  def initialize
    @cards = []
    ["\u2660", "\u2665", "\u2663", "\u2666"].each do |suit|
      [(6..10).to_a, 'J', 'Q', 'K', 'A'].flatten.each do |name|
        @cards << Card.new(name, suit)
      end
    end
    @cards.shuffle!(random: Random.new)
  end

  def take_card
    @cards.shift
  end
end

