require 'minitest/autorun'
require 'minitest/pride'
require './lib/card'
require './lib/turn'
require './lib/deck'
require './lib/round'

class RoundTest < Minitest::Test

  def setup
    @card1 = Card.new("What is the smallest atomic element?", "Helium",:Chemistry)
    @card2 = Card.new("What is banned in Japanese restaurants?", "Tipping", :Law)
    @card3 = Card.new("What is illegal to duel with in Massachesetts?", "Water Pistols", :Law)
    @cards = [@card1, @card2, @card3]
    @deck = Deck.new(@cards)


    @round = Round.new(@deck)
    @turn1 = @round.take_turn("Helium")
    @turn2 = @round.take_turn("Tipping")
    @turn3 = @round.take_turn("Water Pistols")
  end


  def test_it_exists


    assert_instance_of Round, @round
  end

  def test_it_has_a_deck


    assert_equal @deck, @round.deck
  end

  def test_it_has_a_current_card


    assert_equal @card1, @round.current_card
  end

  def test_it_tracks_turns


    assert_equal [], @round.turns

    @turn1 = @round.take_turn("Helium")

    assert_equal [@turn1], @round.turns

  end

  def test_it_returns_number_correct


    assert_equal 3, @round.number_correct
  end

  def test_it_returns_number_correct_by_category



    assert @turn1.correct?
    refute @turn2.correct?
    assert @turn3.correct?

    assert_equal 1, @round.number_correct_by_category(:Chemistry)
    assert_equal 1, @round.number_correct_by_category(:Law)
  end

  def test_it_returns_percent_correct


    @round.number_correct
    assert_equal 100.0, @round.percent_correct
  end

  def test_it_returns_percent_correct_by_category





    assert_equal 100.0, @round.percent_correct_by_category(:Chemistry)
    assert_equal 50.0, @round.percent_correct_by_category(:Law)

  end



end
