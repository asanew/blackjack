require_relative 'gamer'

class Dealer < Gamer
  def to_s
    "Dealer has cards: #{'** '*@cards.length} and $#{@wallet} in wallet"
  end

  def show_cards
    "Dealer has cards: #{@cards*' '}"
  end

  def think(deck)
    if calc_points <= 18 && @cards.length == 2
      get_card(deck)
    end
  end
end
