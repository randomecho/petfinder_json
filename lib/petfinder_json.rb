require 'json'
require 'net/http'
require 'petfinder_json/configuration'
require 'petfinder_json/client'
require 'petfinder_json/breeds'
require 'petfinder_json/shelter'

module PetfinderJSON
  extend Configuration
  extend Client
end