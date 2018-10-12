# frozen_string_literal: true

class CliView
  def show_message(message)
    puts begin
      if message.is?(:start_game)
        "Let's play Hit and Blow!"
      elsif message.is?(:wrong)
        hint = message.value
        "Wrong. #{hint[:hit]}Hit, #{hint[:blow]}Blow"
      elsif message.is?(:you_win)
        'Correct! You win.'
      end
    end
  end

  def take_user_guess
    loop do
      puts 'Guess the numbers!'

      guess = Numbers.parse(STDIN.gets.strip)

      return guess unless guess.nil?

      puts 'Invalid input.'
    end
  end
end
