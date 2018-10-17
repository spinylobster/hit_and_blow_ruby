# Hit & Blow

to practice Ruby.

## Test Result

```bash
$ bundle install
$ bundle exec rspec -f doc

CliView
  #show_message
    Message(start_game)
      should output "Let's play Hit and Blow!\n" to stdout
    Message(wrong, {:hit=>1, :blow=>1})
      should output "Wrong. 1Hit, 1Blow\n" to stdout
    Message(you_win)
      should output "Correct! You win.\n" to stdout
  #take_user_guess
    valid inputs
      1234
        should eq Numbers(1, 2, 3, 4)
      5678
        should eq Numbers(5, 6, 7, 8)
    invalid inputs
      a234
        should output "Guess the numbers!\nInvalid input.\nGuess the numbers!\n" to stdout
        finally got valid guess
          should eq Numbers(1, 2, 3, 4)
      12345
        should output "Guess the numbers!\nInvalid input.\nGuess the numbers!\n" to stdout
        finally got valid guess
          should eq Numbers(1, 2, 3, 4)

Game
  #play
    should be done with user win
  #judge
    {:answer=>Numbers(1, 2, 3, 4), :guess=>Numbers(1, 2, 3, 4)}
      should eq {:hint=>{:blow=>0, :hit=>4}, :is_correct=>true}
    {:answer=>Numbers(1, 2, 3, 4), :guess=>Numbers(1, 4, 5, 6)}
      should eq {:hint=>{:blow=>1, :hit=>1}, :is_correct=>false}
    {:answer=>Numbers(1, 2, 3, 4), :guess=>Numbers(4, 3, 2, 0)}
      should eq {:hint=>{:blow=>3, :hit=>0}, :is_correct=>false}
    {:answer=>Numbers(1, 2, 3, 4), :guess=>Numbers(4, 3, 2, 2)}
      should eq {:hint=>{:blow=>4, :hit=>0}, :is_correct=>false}

Finished in 0.01935 seconds (files took 0.14812 seconds to load)
14 examples, 0 failures
```

