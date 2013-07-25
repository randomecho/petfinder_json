require 'petfinder_json'

describe PetfinderJSON::Client do

  before do
    PetfinderJSON.configure do |config|
      config.api_key = 'YOUR_API_KEY'
      config.api_secret = 'YOUR_API_SECRET'
    end

    @pet = PetfinderJSON.pet('26108370')
    @pet_gerbil = PetfinderJSON.pet('25491955')
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

    it 'another pet is a single type breed' do
      @pet_gerbil.breed.should include('Gerbil')
    end

    it 'has no contact email address' do
      @pet.email.should == nil
    end

    it 'has contact email address' do
      @pet_gerbil.email.should == 'pikecountyhs@gmail.com'
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