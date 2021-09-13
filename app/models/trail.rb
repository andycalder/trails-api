class Trail < ApplicationRecord
	validates :name, presence: true
  validates :difficulty, presence: true, inclusion: { in: %w(Beginner Intermediate Advanced Expert Proline) }
  validates :category, presence: true, inclusion: { in: %w(Freeride Technical) }
  validates :zone, presence: true, inclusion: { in: ['Fitzsimmons Zone', 'Garbanzo Zone', 'Creekside Zone', 'Peak Zone'] }
  validates :start_lat, presence: true
  validates :start_lng, presence: true
  validates :mapbox_id, presence: true
end
