# frozen_string_literal: true

require_relative '../lib/cli_view'
require_relative '../lib/message'
require_relative '../lib/numbers'

describe CliView do
  let(:view) { CliView.new }

  describe '#show_message' do
    let(:show_result) { view.show_message(subject) }

    context Message.start_game do
      it { expect { show_result }.to output("Let's play Hit and Blow!\n").to_stdout }
    end

    context Message.wrong(hit: 1, blow: 1) do
      it { expect { show_result }.to output("Wrong. 1Hit, 1Blow\n").to_stdout }
    end

    context Message.you_win do
      it { expect { show_result }.to output("Correct! You win.\n").to_stdout }
    end
  end

  describe '#take_user_guess' do
    valid_input = "1234\n"
    let(:valid_guess) { Numbers.new(1, 2, 3, 4) }

    before { allow(STDIN).to receive(:gets).and_return *inputs }

    describe 'valid inputs' do
      let(:outputs) { "Guess the numbers!\n" }

      before { allow(STDOUT).to receive(:puts).with('Guess the numbers!') }

      context valid_input do
        let(:inputs) { [valid_input] }

        it { expect(view.take_user_guess).to eq valid_guess }
      end

      valid_input2 = "5678\n"
      let(:valid_guess2) { Numbers.new(5, 6, 7, 8) }
      context valid_input2 do
        let(:inputs) { [valid_input2] }

        it { expect(view.take_user_guess).to eq valid_guess2 }
      end
    end

    describe 'invalid inputs' do
      let(:outputs) { "Guess the numbers!\nInvalid input.\nGuess the numbers!\n" }

      not_number = "a234\n"
      size_unmatch = "12345\n"

      finally_got_valid_guess = 'finally got valid guess'
      shared_examples finally_got_valid_guess do
        describe finally_got_valid_guess do
          before do
            allow(STDOUT).to receive(:puts).with('Guess the numbers!')
            allow(STDOUT).to receive(:puts).with('Invalid input.')
            allow(STDOUT).to receive(:puts).with('Guess the numbers!')
          end

          it { expect(view.take_user_guess).to eq valid_guess }
        end
      end

      context not_number do
        let(:inputs) { [not_number, valid_input] }

        it { expect { view.take_user_guess }.to output(outputs).to_stdout }
        include_examples finally_got_valid_guess
      end

      context size_unmatch do
        let(:inputs) { [not_number, valid_input] }

        it { expect { view.take_user_guess }.to output(outputs).to_stdout }
        include_examples finally_got_valid_guess
      end
    end
  end
end
