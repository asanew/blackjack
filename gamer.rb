require_relative 'deck'
require_relative 'card'

class Gamer
  attr_reader :wallet, :cards

  def initialize
    @wallet = 100
    @cards = []
  end
  
  def bet(ammount = 10)
    @wallet -= ammount
    raise "Not enough money" if @wallet < 0
    return ammount
  end

  def gain(ammount)
    @wallet += ammount
  end

  def get_card(deck)
    @cards << deck.take_card
  end

  def drop_cards
    @cards = []
  end

  def calc_points
    points = 0
    has_aces = false
    cards.each do |card|
      points += card.value
      has_aces = true if card.is_ace?
    end
    points += 10 if has_aces && points + 10 <= 21
    return points
  end

  def to_s
    "Gamer has cards: #{@cards*" "} and $#{@wallet} in wallet"
  end
end
