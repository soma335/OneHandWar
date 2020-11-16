5.times do |n|
  User.create!(
      email: "test#{n + 1}@test.com",
      name: "西軍太郎#{n + 1}",
      password: "test#{n + 1}02",
      confirmed_at: Time.now,
      belong: 1
  )
  Combat.create!(user_id:"#{n + 1}", battle_record:50)
end

5.times do |n|
  User.create!(
      email: "passt#{n + 6}@test.com",
      name: "東軍太郎#{n + 1}",
      password: "test#{n + 1}02",
      confirmed_at: Time.now,
      belong: 0
  )
  Combat.create!(user_id:"#{n + 6}", battle_record:50)
end