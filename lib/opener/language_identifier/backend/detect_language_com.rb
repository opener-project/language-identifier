module Opener
  class LanguageIdentifier
    module Backend
      class DetectLanguageCom

        ##
        # Unknown or languages that use a different code
        #
        CODE_MAP = {
          bug: nil,
          ceb: :tl,
          chr: nil,
          crs: nil,
          egy: nil,
          got: nil,
          haw: nil,
          hmn: nil,
          iw:  :he,
          jw:  :jv,
          kha: nil,
          lif: :li,
          mfe: nil,
          nso: nil,
          sco: nil,
          syr: nil,
          tlh: nil,
          war: :tl,
          zh:  :'zh-cn',
          'zh-Hant': :'zh-cn',
          'zh-tw':   :'zh-cn',
        }

        def initialize
          DetectLanguage.configure do |config|
            config.secure  = true
            config.api_key = ENV['DETECT_LANGUAGE_TOKEN']
            config.http_read_timeout = 300
            config.http_open_timeout = 300
            raise 'no detectlanguage token specified' if config.api_key.nil?
          end
        end

        def detect input
          code = DetectLanguage.simple_detect input
          return 'unknown' unless code

          mapped_code = CODE_MAP[code.to_sym]
          return mapped_code.to_s if mapped_code

          code

        rescue => e
          puts "detect_language: retrying on #{e.class}: #{e.message}"
          retry
        end

      end
    end
  end
end
