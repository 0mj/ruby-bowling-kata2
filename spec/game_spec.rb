# frozen_string_literal: true

require_relative "../lib/game"

RSpec.describe Game do
  let(:game) { Game.new }
  # test1
  it "20 rolls of 0 scores a 0" do
    roll_many(20, 0)
    expect(game.score).to eq(0)
  end

  # test2
  it "10 gutters and 10 1s scores 10" do
    roll_many(10, 0)
    roll_many(10, 1)
    expect(game.score).to eq(10)
  end

  # test3 picking up spare
  it "Rolling 5, 5, 3 followed by 17 rolls of 0 must score 16" do
    roll_spare
    game.roll(3)
    roll_many(17, 0)
    expect(game.score).to eq(16)
  end

  # test4 roll strike
  it "Rolling a 10, 3, 4 and 16 gutters must score 24" do
    roll_strike
    game.roll(3)
    game.roll(4)
    roll_many(16, 0)
    expect(game.score).to eq(24)
  end

  # test 5 perfect game
  it "Rolls 12 strikes and scores 300" do
    roll_many(12, Game::PINS)
    expect(game.score).to eq(300)
  end

  def roll_many(rolls, pins)
    rolls.times do
      game.roll(pins)
    end
  end

  def roll_spare
    roll_many(2, 5)
  end

  def roll_strike
    game.roll(Game::PINS)
  end
end
