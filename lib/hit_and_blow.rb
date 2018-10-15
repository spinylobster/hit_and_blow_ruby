# frozen_string_literal: true

require_relative './numbers'

class HitAndBlow
  def self.count_hit_blow(answer, guess)
    hit = answer.value.each_with_index.count do |x, i|
      guess.value[i] == x
    end

    blow = guess.value.each_with_index.count do |x, i|
      answer.value.each_with_index.any? do |y, j|
        i != j && x == y
      end
    end

    { hit: hit, blow: blow }
  end
end
