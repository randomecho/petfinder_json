require 'petfinder_json'

describe PetfinderJSON::Client do

  before do
    PetfinderJSON.configure do |config|
      config.api_key = 'YOUR_API_KEY'
      config.api_secret = 'YOUR_API_SECRET'
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