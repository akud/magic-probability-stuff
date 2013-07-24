#!/usr/bin/env ruby

class Card
  def initialize(is_land=false)
    @is_land = is_land
  end
  def is_land?; @is_land; end
end

def make_deck num_lands, total=60
  lands = Array.new(num_lands) {Card.new(true)}
  non_lands = Array.new(total - num_lands) {Card.new}
  (lands + non_lands).shuffle
end

def num_draws_to_hit_lands(deck, count)
  num_lands = 0
  num_cards = 0
  until num_lands == count
    card = deck.pop
    num_lands += card.is_land? ? 1 : 0
    num_cards += 1
  end
  num_cards
end

class Array
  def mean
    self.inject(:+).to_f/self.length
  end
end

def avg_draws_to_hit_lands(num_lands, number_to_hit)
  Array.new(1000) do
    deck = make_deck(num_lands)
    num_draws_to_hit_lands(deck, number_to_hit)
  end.mean
end

num_lands_in_deck = ARGV[0].to_i
num_lands_to_see = ARGV[1].to_i

result = avg_draws_to_hit_lands(num_lands_in_deck, num_lands_to_see)
puts "Average number of cards to see #{num_lands_to_see} lands with #{num_lands_in_deck} lands in deck: #{result}"
