puts 'Seeding...'
UpdateTrailsJob.update_trails
puts "Seeded #{Trail.count} trails."
