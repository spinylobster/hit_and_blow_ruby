# frozen_string_literal: true

class Message
  attr_accessor :kind, :value

  def initialize(kind, value = nil)
    @kind = kind
    @value = value
  end

  def is?(kind)
    @kind == kind
  end

  def to_s
    if @value
      "Message(#{@kind}, #{@value})"
    else
      "Message(#{@kind})"
    end
  end

  def self.start_game
    new(:start_game)
  end

  def self.wrong(hint)
    new(:wrong, hint)
  end

  def self.you_win
    new(:you_win)
  end
end
