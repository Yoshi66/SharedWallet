namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    Project.create!(content: "a",
                 user_id: 1,
                 place: "Portland",
                 name: "Project 1")
    99.times do |n|
      content  = "project {n+1}"
      user_id = "{n+1}"
      place  = "My place"
      name = Faker::Name.name
      Project.create!(content: content,
                   user_id: user_id,
                   place: place,
                   name: name)
    end
  end
end