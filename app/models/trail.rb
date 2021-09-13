class Trail < ApplicationRecord
	validates :name, presence: true
  validates :difficulty, presence: true, inclusion: { in: %w(Beginner Intermediate Advanced Expert Proline) }
  validates :category, presence: true, inclusion: { in: %w(Freeride Technical) }
  validates :zone, presence: true, inclusion: { in: ['Fitzsimmons Zone', 'Garbanzo Zone', 'Creekside Zone', 'Peak Zone'] }
  validates :start_lat, presence: true
  validates :start_lng, presence: true
  validates :mapbox_id, presence: true

  def self.from_geojson_feature(feature)
    props = feature['properties']
    coords = feature['geometry']['coordinates']

    if props['type'] && %w(technical freeride).include?(props['type'])
      record = Trail.find_or_initialize_by(mapbox_id: feature['id'])

      record.update(
        name: props['name'],
        difficulty: props['difficulty'].capitalize,
        category: props['type'].capitalize,
        zone: props['zone'],
        start_lat: coords.first[1],
        start_lng: coords.first[0],
      )

      if record.valid?
        record.save
      else
        puts 'Unable to save record'
        p record
      end
    end
  end
end
