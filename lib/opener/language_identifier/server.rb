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
      accepted_params :input, :kaf

      ##
      # Gets the Analyzed output of an input.
      #
      # @param [Hash] options The options for the text_processor
      # @return [String] output the output of the text_processor
      # @return [Symbol] type the output type ot the text_processor
      #
      # @raise RunetimeError Raised when the tagging process failed.
      #
      def analyze(options)
        processor = text_processor.new(options)
        output    = processor.run(options[:input])
        
        return output
      end
    end # Server
  end # LanguageIdentifier
end # Opener
