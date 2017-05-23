class Card
  attr_reader :suit, :name, :value

  def initialize(name, suit)
    values = {'J' => 10, 'Q' => 10, 'K' => 10, 'A' => 11}
    @suit = suit
    @name = name
    @value = values[name] || name
  end

  def to_s
    "#{@name}#{@suit}"
  end
end

