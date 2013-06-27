require 'sinatra/base'
require 'httpclient'
require 'opener/webservice'

module Opener
  class LanguageIdentifier
    ##
    # A basic language identification server powered by Sinatra.
    #
    class Server < Webservice
      set :views, File.expand_path('../views', __FILE__)
      text_processor LanguageIdentifier
      accepted_params :input, :kaf, :extended
    end # Server
  end # LanguageIdentifier
end # Opener