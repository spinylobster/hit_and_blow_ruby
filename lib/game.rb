# frozen_string_literal: true

require_relative './numbers'
require_relative './message'

class Game
  attr_accessor :answer

  def initialize(view)
    @answer = nil
    @view = view
  end

  def play
    @answer ||= Numbers.gen_random

    @view.show_message(Message.start_game)

    game_loop
  end

  def judge(guess)
    if @answer == guess
      { is_correct: true, hint: { hit: 4, blow: 0 } }
    else
      { is_correct: false, hint: @answer.count_hit_blow(guess) }
    end
  end

  private

  def game_loop
    loop do
      user_guess = @view.take_user_guess

      result = judge(user_guess)

      if result[:is_correct]
        @view.show_message(Message.you_win)
        break
      else
        @view.show_message(Message.wrong(result[:hint]))
      end
    end
  end
end
