require 'tempfile'

module Opener
  module Kernel
    module Vicom
      module LanguageIdentifier
        module Lite
          class ALL 
            VERSION = "0.0.2"

            attr_reader :kernel, :lib

            def initialize
              core_dir    = File.expand_path("../core", File.dirname(__FILE__))

              @kernel      = core_dir+'/language_detector.pl'
              @lib         = core_dir+'/lib/'
            end

            def command(opts={})
              arguments = opts[:arguments] || []

              puts "perl -I #{lib} #{kernel} #{arguments.join(' ')} #{opts[:input]}"
              "perl -I #{lib} #{kernel} #{arguments.join(' ')} #{opts[:input]}"

            end

          end
        end
      end
    end
  end
end


