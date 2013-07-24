def chance_to_hit_in_opening_hand(num_lands, deck_size=60)
  negative_probability = 1.0
  num_non_lands = deck_size - num_lands

  7.times do |i|
    num_cards_left = deck_size - i
    non_lands_left = num_non_lands - i
    negative_probability *= (non_lands_left.to_f / num_cards_left)
  end

  (1.0 - negative_probability).round(2)
end

num_lands = ARGV[0].to_i
result = chance_to_hit_in_opening_hand(num_lands)
puts "Chance to draw one land in opening hand with #{num_lands} in deck: #{result}"
