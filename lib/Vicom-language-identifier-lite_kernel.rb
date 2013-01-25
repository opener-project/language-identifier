module Opener
   module Kernel
     module Vicom
       module LanguageIdentifier
        module Lite
      	VERSION = "0.0.1"

      	class Configuration
        	CORE_DIR    = File.expand_path("../core", File.dirname(__FILE__))
        	KERNEL_CORE = CORE_DIR+'/language_detector.pl'
      	end
      end
      end
    end
  end
end

KERNEL_CORE=Opener::Kernel::Vicom::LanguageIdentifier::Lite::Configuration::KERNEL_CORE
