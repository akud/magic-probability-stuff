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

  def to_histogram
    each_with_object(Hash.new(0)) { |i, acc| acc[i] += 1 }
  end
end

def run_simulation(num_lands, number_to_hit)
  Array.new(1000) do
    deck = make_deck(num_lands)
    num_draws_to_hit_lands(deck, number_to_hit)
  end
end

def print_histogram histogram
  vertical_size = histogram.values.max
  keys = histogram.keys.sort

  vertical_size.times.each do |i|
    keys.each do |key|
      current_height = vertical_size - i
      value = histogram[key]
      number_of_spaces = key.to_s.length
      has_star = value >= current_height
      char = has_star ? "*" : " "

      number_of_spaces.times { print char }
      print has_star ? "|" : " "
    end
    puts
  end
  keys.each {|k| print "#{k}|" }
  puts
end

num_lands_in_deck = ARGV[0].to_i
num_lands_to_see = ARGV[1].to_i

results = run_simulation num_lands_in_deck, num_lands_to_see

puts "Average number of cards to see #{num_lands_to_see} lands with #{num_lands_in_deck} lands in deck: #{results.mean}"
puts "Histogram: "
print_histogram results.to_histogram
