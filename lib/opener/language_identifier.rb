require_relative 'language_identifier/version'

module Opener
  class LanguageIdentifier
    attr_reader :kernel, :lib

    def command(opts={})
      "perl -I #{lib} #{kernel} #{opts.join(' ')}"
    end

    def run(opts=ARGV)
      `#{command(opts)}`
    end

    protected

    def core_dir
      File.expand_path("../../../core", __FILE__)
    end

    def kernel
      File.join(core_dir,'language_detector.pl')
    end

    def lib
      File.join(core_dir,'lib/') # Trailing / is required
    end

  end
end
