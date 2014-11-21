require 'opener/webservice'

module Opener
  class LanguageIdentifier
    ##
    # A basic language identification server powered by Sinatra.
    #
    class Server < Opener::Webservice::Server
      set :views, File.expand_path('../views', __FILE__)

      self.text_processor  = LanguageIdentifier
      self.accepted_params = [:input, :kaf]
    end # Server
  end # LanguageIdentifier
end # Opener
