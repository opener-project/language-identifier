module Opener
  class LanguageIdentifier
    module Backend
      class Opennlp

        include_package 'opennlp.tools.langdetect'

        MODEL_FILE  = File.expand_path '../../../../core/target/opennlp/langdetect-183.bin', File.dirname(__FILE__)
        ISOCODE_MAP = {
          afr: :af,
          ara: :ar,
          aze: :az,
          bak: :ba,
          bel: :be,
          ben: :bn,
          bos: :bs,
          bre: :br,
          bul: :bg,
          cat: :ca,
          ces: :cs,
          che: :ce,
          cmn: :zh,
          nan: :zh,
          cym: :cy,
          dan: :da,
          deu: :de,
          gsw: :de,
          nds: :de,
          ell: :el,
          eng: :en,
          epo: :eo,
          est: :et,
          ekk: :et,
          eus: :eu,
          fao: :fo,
          fin: :fi,
          fra: :fr,
          fry: :fy,
          gle: :ga,
          glg: :gl,
          guj: :gu,
          heb: :he,
          hin: :hi,
          hrv: :hr,
          hun: :hu,
          hye: :hy,
          ind: :id,
          isl: :is,
          ita: :it,
          jav: :jv,
          jpn: :ja,
          kan: :kn,
          kat: :ka,
          kaz: :kk,
          kir: :ky,
          kor: :ko,
          lat: :la,
          lim: :li,
          lit: :lt,
          ltz: :lb,
          lav: :lv,
          lvs: :lv,
          mal: :ml,
          mar: :mr,
          mkd: :mk,
          mlt: :mt,
          mon: :mn,
          mri: :mi,
          min: :ms,
          msa: :ms,
          nep: :ne,
          nld: :nl,
          nno: :nn,
          nob: :nb,
          oci: :oc,
          pan: :pa,
          fas: :fa,
          pes: :fa,
          pol: :pl,
          por: :pt,
          pus: :ps,
          ron: :ro,
          rus: :ru,
          san: :sa,
          sin: :si,
          slk: :sk,
          slv: :sl,
          som: :so,
          spa: :es,
          sqi: :sq,
          srp: :sr,
          sun: :su,
          swa: :sw,
          swe: :sv,
          tam: :ta,
          tat: :tt,
          tel: :te,
          tgk: :tg,
          tgl: :tl,
          tha: :th,
          tur: :tr,
          ukr: :uk,
          urd: :ur,
          uzb: :uz,
          vie: :vi,
          vol: :vo,
          zul: :zu,
        }

        def initialize
          model_file = java.io.File.new MODEL_FILE
          input      = java.io.FileInputStream.new model_file
          @model     = LanguageDetectorModel.new input
          @detector  = LanguageDetectorME.new @model
        end

        def detect input
          language = @detector.predictLanguage input
          return 'unknown' unless language

          pp language.getLang
          code     = ISOCODE_MAP[language.getLang.to_sym]
          return 'unknown' unless code

          code.to_s
        end


      end
    end
  end
end

