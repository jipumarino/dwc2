# coding: utf-8
class Comparacion < ActiveRecord::Base

  Idiomas = {'eng' => 'Inglés', 'spa' => 'Español'}

  ALLOWED_WORDS = %w(ADJ ADV NC NMEA NMON NP ORD PE PNC UMMX VCLIfin VCLIger VCLIinf VEadj VEfin VEger VEinf VHadj VHfin VHger VHinf VLadj VLfin VLger VLinf VMadj VMfin VMger VMinf VSadj VSfin VSger VSinf)

  validates_inclusion_of :idioma, :in => Idiomas 
  
  def archivo1= archivo
    self[:data1] = archivo.read
    self[:archivo1] = archivo.original_filename
  end

  def archivo2= archivo
    self[:data2] = archivo.read
    self[:archivo2] = archivo.original_filename
  end

  def get_tagged data
    lang = idioma == 'eng' ? 'english' : 'spanish'
    process = IO.popen("sh #{`which tree-tagger-#{lang}`}", 'w+')
    process.puts data
    process.close_write
    out = process.read
    process.close
    tagged = out.split("\n").map do |x|
      cols = x.split("\t")

      if ALLOWED_WORDS.index(cols[1])
        cols[2] == "<unknown>" ? cols[0] : cols[2]
      else
        "--NOVAL--"
      end
    end
    tagged.select{|x| x!="--NOVAL--"}
    tagged.join("\n")
  end

  def get_freqs tagged
    f={}
    tagged.delete("\r.,;:¡!¿?()$_@#\"").gsub("|","\n").gsub("~","\n").split("\n").each do |x|
      x = x.downcase.gsub(/^-/,"").gsub(/-$/,"")
      next if x.empty?
      f[x].nil? ? f[x] = 1 : f[x] += 1
    end    
    num_words = f.size.to_f

    f.merge(f){|k,v| {:freq_abs => v, :freq_rel => v/num_words}}
  end

  def get_freqs_diff freqs1, freqs2
    df = {}
    freqs2.merge(freqs2) do |word, values|
      df = freqs1[word].nil? ? values[:freq_rel]*freqs1.size : values[:freq_rel]/freqs1[word][:freq_rel]
      {:freq_abs => values[:freq_abs], :freq_rel => values[:freq_rel], :freq_diff => df}
    end
  end

  def freqs_diff
    get_freqs_diff(
      get_freqs(get_tagged(self[:data1])),
      get_freqs(get_tagged(self[:data2]))
    )
  end
end
