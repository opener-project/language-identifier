require 'sinatra/base'

module Opener
  class LanguageIdentifier
    ##
    # A basic language identification server powered by Sinatra.
    #
    class Server < Sinatra::Base
      configure do
        enable :logging
      end

      ##
      # Provides a page where you see a textfield and you can post stuff
      #
      get '/' do
        erb :index
      end

      ##
      # Identifies a given text.
      #
      # @param [Hash] params The POST parameters.
      #
      # @option params [String] :text The text to identify.
      # @option params [TrueClass|FalseClass] :kaf Whether or not to use KAF
      #  output.
      # @option params [TrueClass|FalseClass] :extended Whether or not to use
      #  extended language detection.
      #
      post '/' do
        output = identify_text(params[:text])

        body output
      end

      ##
      # @param [String] text The text to identify.
      # @return [String]
      #
      def identify_text(text)
        identifier = LanguageIdentifier.new(options_from_params)
        output, *_ = identifier.run(text)

        return output
      end

      ##
      # Returns a Hash containing various GET/POST parameters extracted from
      # the `params` Hash.
      #
      # @return [Hash]
      #
      def options_from_params
        options = {}

        [:kaf, :extended, :callback].each do |key|
          options[key] = params[key]
        end

        return options
      end
    end # Server
  end # LanguageIdentifier
end # Opener
