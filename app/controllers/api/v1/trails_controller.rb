class Api::V1::TrailsController < ApplicationController
	def index
    @trails = Trail.all
    render json: trails_json
  end

  private

  def trails_json
    trails_array = @trails.map do |trail|
      {
        name: trail.name,
        difficulty: trail.difficulty,
        category: trail.category,
        zone: trail.zone,
        start: [trail.start_lng, trail.start_lat]
      }
    end

    { trails: trails_array }
  end
end
