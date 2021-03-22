# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Challenge.destroy_all

4.times do 
  numb_guests = rand(3..8)
  puts numb_guests
  c = Challenge.create(title: Faker::Dessert.variety, description: "C'est ça qu'c'est bon !", numb_guest: numb_guests)

  numb_guests.times do |i|
    name = Faker::Name.first_name.downcase
    u = User.find(i +1)
    if i == 0
      surveyor_id = u.id
    end
    
    g = Guest.create(username: u.username, email: u.email, challenge_id: c.id)
    e = Event.create(user_id: u.id, challenge_id: c.id)
    
    (numb_guests - 1).times do
      s = Survey.create(event_id: e.id, surveyor_id: surveyor_id)
      Question.create(label: "le goût", grade: rand(1..4), survey_id: s.id)
      Question.create(label: "la présentation", grade: rand(1..4), survey_id: s.id)
      Question.create(label: "l'ambiance'", grade: rand(1..4), survey_id: s.id)      
    end
  end
end