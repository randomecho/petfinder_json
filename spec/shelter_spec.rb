require 'petfinder_json'

describe PetfinderJSON::Shelter do

  before do
    PetfinderJSON.configure do |config|
      config.api_key = 'YOUR_API_KEY'
      config.api_secret = 'YOUR_API_SECRET'
    end
  end

  describe 'shelter methods' do
    it 'get shelter info' do
      shelter = PetfinderJSON.shelter('KY361')
      shelter.name.should == 'Little Hills of Kentucky Animal Rescue, Inc.'
    end

    it 'find shelters based on location' do
      shelters = PetfinderJSON.find_shelters('40509')
      shelters.count.should > 1
    end

    it 'find shelters based on location, name' do
      shelters = PetfinderJSON.find_shelters('40509', :name => 'pets')
      shelters.count.should > 1
    end

    it 'find shelters by animal, breed' do
      shelters = PetfinderJSON.shelters_by_breed('dog', 'Hound')
      shelters.count.should > 1
    end

  end
end