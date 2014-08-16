require 'spec_helper'

describe Category do
  it { should have_many :videos }
  it { should validate_presence_of :name }

  let(:comedies) { Category.create(name: 'comedies') }

  describe "#recent_videos"
    it 'returns the videos in the reverse chronological order by created_at' do
      futurama = Video.create(title:"Futurama", description: 'Space Travel!', category: comedies, created_at: 1.day.ago)
      south_park = Video.create(title: 'South Park', description: 'Crazy Kids', category: comedies)
      expect(comedies.recent_videos).to eq([south_park, futurama])
    end

    it 'returns all the videos if there are less than six videos' do
      futurama = Video.create(title:"Futurama", description: 'Space Travel!', category: comedies, created_at: 1.day.ago)
      south_park = Video.create(title: 'South Park', description: 'Crazy Kids', category: comedies)
      expect(comedies.recent_videos.count).to eq(2)
    end

    it 'returns only six videos if there are more than six videos in the category' do
      7.times { Video.create(title: 'foo', description: 'bar', category: comedies) }
      expect(comedies.recent_videos.count).to eq(6)
    end

    it 'returns the most recent six videos' do
      6.times { Video.create(title: 'foo', description: 'bar', category: comedies) }
      tonight_show = Video.create(title: 'The Tonight Show', description: 'comedy, satire talk show', category: comedies, created_at: 1.day.ago)
      expect(comedies.recent_videos).not_to include(tonight_show)
    end

    it 'returns an empty array if the category does not have any videos' do
      expect(comedies.recent_videos).to eq([])
    end
end
