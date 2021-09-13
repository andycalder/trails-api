class UpdateTrailsJob < ApplicationJob
  queue_as :default

  def perform
    puts 'Updating trails...'
    sleep 3
    puts 'Finished updating trails.'
  end

  def self.fetch_json
    dataset_id = 'cj51y5ioi09wh32p1s9frlt9l'
    access_token = ENV['MAPBOX_ACCESS_TOKEN']
    dataset_url = "https://api.mapbox.com/datasets/v1/andycalder/#{dataset_id}/features?access_token=#{access_token}"

    URI.open(dataset_url).read
  end

  def self.update_trails
    dataset = self.fetch_json
    features = JSON.parse(dataset)['features']

    features.each do |feature|
      Trail.from_geojson_feature(feature)
    end
  end
end
