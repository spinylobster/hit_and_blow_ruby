# frozen_string_literal: true

require './lib/game'
require './lib/cli_view'

game = Game.new(CliView.new)
game.play
