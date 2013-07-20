require 'petfinder_json'

describe PetfinderJSON::Client do

  before do
    PetfinderJSON.configure do |config|
      config.api_key = 'YOUR_API_KEY'
      config.api_secret = 'YOUR_API_SECRET'
    end

    @pet = PetfinderJSON.pet('26108370')
  end

  describe 'pet details' do

    it 'get a specific pet' do
      @pet.name.should == 'Asher'
    end

    it 'specific pet has had its shots' do
      @pet.options.should include('hasShots')
    end

    it 'and is of a particular breed' do
      @pet.breed.should include('Cairn Terrier')
    end

  end

  describe 'breed info' do
    it 'gets list of breeds per animal' do
      breeds = PetfinderJSON.breeds('barnyard')
      breeds.breeds_list.count.should > 1
      breeds.breeds_list.first.should == 'Alpaca'
    end

  end
end