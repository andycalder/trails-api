puts 'Seeding...'

dataset_id = 'cj51y5ioi09wh32p1s9frlt9l'
access_token = ENV['MAPBOX_ACCESS_TOKEN']
dataset_url = "https://api.mapbox.com/datasets/v1/andycalder/#{dataset_id}/features?access_token=#{access_token}"
puts dataset_url
dataset = URI.open(dataset_url).read
features = JSON.parse(dataset)['features']

features.each do |feature|
  props = feature['properties']
  coords = feature['geometry']['coordinates']

  if props['type'] && %w(technical freeride).include?(props['type'])
    record = Trail.new(
      name: props['name'],
      difficulty: props['difficulty'].capitalize,
      category: props['type'].capitalize,
      zone: props['zone'],
      start_lat: coords.first[1],
      start_lng: coords.first[0],
      mapbox_id: feature['id']
    )

    if record.valid?
      record.save
    else
      puts 'Unable to save record'
      p record
    end
  end
end

puts "Seeded #{Trail.count} trails."
