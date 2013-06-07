require 'sinatra'

module Opener
  class LanguageIdentifier
    class ServerHooks
    end
    class Server < Sinatra::Base

      ##
      # Arguments:
      #
      # input --> text
      # callback --> post to this url when you're done, return a 202 immediately
      # KAF --> if true, output KAF
      # extended --> if true, pass the -d option to the language-identifier
      #
      post '/' do
        text = params.delete("text")
        identifier = Opener::LanguageIdentifier.new(options_from_params)

        output, error, process = identifier.run(text)
        body output
      end

      ##
      # Provides a page where you see a textfield and you can post stuff
      #
      get '/' do
        erb :index
      end

      def options_from_params
        options = {}
        options[:kaf]      = params[:kaf]
        options[:extended] = params[:extended]
        options[:callback] = params[:callback]
        return options
      end
    end
  end
end

