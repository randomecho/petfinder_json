module PetfinderJSON
  module Configuration
    DEFAULT_API_KEY    = nil
    DEFAULT_API_SECRET = nil
    DEFAULT_ENDPOINT   = 'http://api.petfinder.com'

    attr_accessor :api_key, :api_secret

    def configure
      yield self
    end
 
    # Reset config values when extended by calling class
    def self.extended(base)
      base.reset
    end
 
    # Only the API keys need to be set by the user
    def reset
      self.api_key    = DEFAULT_API_KEY
      self.api_secret = DEFAULT_API_SECRET
    end
  end
end