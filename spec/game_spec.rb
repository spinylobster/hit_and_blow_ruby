# frozen_string_literal: true

require_relative '../lib/game'
require_relative '../lib/cli_view'
require_relative '../lib/numbers'

describe Game do
  let(:view) { CliView.new }
  let(:game) { Game.new(view) }

  describe '#play' do
    let(:answer) { Numbers.new(1, 2, 3, 4) }

    let(:inputs) { %W[a123\n 2234\n 1234\n] }
    before { allow(STDIN).to receive(:gets).and_return *inputs }

    it 'should be done with user win' do
      game.answer = answer

      outputs = [
        "Let's play Hit and Blow!",
        'Guess the numbers!',
        'Invalid input.',
        'Guess the numbers!',
        'Wrong. 3Hit, 1Blow',
        'Guess the numbers!',
        'Correct! You win.'
      ]

      outputs.each do |output|
        allow(STDOUT).to receive(:puts).with(output)
      end

      expect(game.play).to eq nil
    end
  end

  describe '#judge' do
    correct_answer = Numbers.new(1, 2, 3, 4)
    hit1blow1 = Numbers.new(1, 4, 5, 6)
    hit0blow3 = Numbers.new(4, 3, 2, 0)
    hit0blow4 = Numbers.new(4, 3, 2, 2)

    let(:result) do
      game.answer = subject[:answer]
      game.judge(subject[:guess])
    end

    context ({ answer: correct_answer, guess: correct_answer }) do
      it { expect(result).to eq ({ is_correct: true, hint: { hit: 4, blow: 0 } }) }
    end

    context ({ answer: correct_answer, guess: hit1blow1 }) do
      it { expect(result).to eq ({ is_correct: false, hint: { hit: 1, blow: 1 } }) }
    end

    context ({ answer: correct_answer, guess: hit0blow3 }) do
      it { expect(result).to eq ({ is_correct: false, hint: { hit: 0, blow: 3 } }) }
    end

    context ({ answer: correct_answer, guess: hit0blow4 }) do
      it { expect(result).to eq ({ is_correct: false, hint: { hit: 0, blow: 4 } }) }
    end
  end
end
