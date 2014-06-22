require 'sidekiq'
require 'net/http'

# A worker to contact deadmanssnitch.com every five minutes,
# thereby ensuring jobs are being performed and the system
# is healthy.
module Sidekiq
  class Snitch
    include Sidekiq::Worker

    def perform
      Net::HTTP.get(URI(ENV['SIDEKIQ_SNITCH_URL']))

      # groundhog day!
      Snitch.perform_in(1.hour)
    end
  end
end