require_relative 'deck'
require_relative 'card'

class Gamer
  attr_reader :bank, :cards

  def initialize
    @bank = 100
    @cards = []
  end
  
  def bet(ammount = 10)
    @bank -= ammount
    raise "Not enough money" if @bank < 0
    return ammount
  end

  def get_card(deck)
    @cards << deck.take_card
  end

  def calc_points
    points = 0
    has_aces = false
    cards.each do |card|
      points += card.value
      has_aces = true if card.value == 1
    end
    points += 10 if has_aces && points + 10 <= 21
    return points
  end

  def to_s
    "Gamer has cards: #{@cards*" "} and $#{@bank} in bank"
  end
end
