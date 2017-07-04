class Card
  attr_reader :suit, :name, :value

  class << self
    attr_accessor :values
  end

  @values = {'J' => 10, 'Q' => 10, 'K' => 10, 'A' => 1}

  def initialize(name, suit)
    @suit = suit
    @name = name
    @value = self.class.values[name] || name
  end

  def to_s
    "#{@name}#{@suit}"
  end

end

