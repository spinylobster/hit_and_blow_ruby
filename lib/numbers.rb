# frozen_string_literal: true

class Numbers
  attr_reader :value

  def initialize(a, b, c, d)
    @value = [a, b, c, d]
  end

  def ==(other)
    @value == other.value
  end

  def inspect
    "Numbers(#{@value.join(', ')})"
  end

  def self.parse(str)
    are_all_digit = str.each_char.all? { |c| ('0'..'9').cover? c }

    if str.size == 4 && are_all_digit
      a, b, c, d = str.each_char.map(&:to_i).to_a
      return new(a, b, c, d)
    end
  end

  def self.gen_random
    a, b, c, d = (0..9).to_a.sample(4)
    new(a, b, c, d)
  end
end
