# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ip_addresses = (IPAddr.new('212.109.223.41')..IPAddr.new('212.109.223.90')).map(&:to_s)
usernames = (0..99).map { ('a'..'z').to_a.sample(6).join }

200_000.times do
  p_service = CreatePost.execute(
    title: Faker::Lorem.sentence,
    body: Faker::Lorem.paragraph(sentence_count: 20),
    author_ip: ip_addresses.sample,
    author_login: usernames.sample
  )
  rand(2).times do
    CreateRating.execute(post_id: p_service.post.id, value: rand(1..5))
  end
end
