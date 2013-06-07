require 'sinatra/base'

module Opener
  class LanguageIdentifier
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
      # Arguments:
      #
      # input --> text
      # callback --> post to this url when you're done, return a 202 immediately
      # KAF --> if true, output KAF
      # extended --> if true, pass the -d option to the language-identifier
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
    end
  end
end
