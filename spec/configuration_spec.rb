require 'petfinder_json'

describe PetfinderJSON::Configuration do
  before do
    PetfinderJSON.reset
  end

  describe 'api key' do
    it 'should return api key' do
      PetfinderJSON.api_key.should == PetfinderJSON::Configuration::DEFAULT_API_KEY
    end

    it 'should set api key' do
      PetfinderJSON.configure do |config|
        config.api_key = 'nachos'
      end
      PetfinderJSON.api_key.should == 'nachos'
    end
  end
  
  describe 'api secret' do
    it 'should return api secret' do
      PetfinderJSON.api_secret.should == PetfinderJSON::Configuration::DEFAULT_API_SECRET
    end

    it 'should set api secret' do
      PetfinderJSON.configure do |config|
        config.api_key = 'secret string'
      end
      PetfinderJSON.api_key.should == 'secret string'
    end
  end

  describe 'endpoint' do
    it 'should return endpoint' do
      PetfinderJSON::Configuration::DEFAULT_ENDPOINT == 'http://api.petfinder.com'
    end
  end

  describe 'format' do
    it 'should return response format as json' do
      PetfinderJSON::Configuration::DEFAULT_FORMAT == 'json'
    end
  end
end