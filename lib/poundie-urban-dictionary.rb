require "nokogiri"
require "cgi"

class UrbanDictionary < Poundie::Plugin
  register :urban_dictionary

  prefix %r/^poundie define\s+/ do |term|
    doc = Nokogiri(get("http://www.urbandictionary.com/define.php?term=" + CGI.escape(term)))
    definitions = doc.search(".definition").map{ |node| node.text }
    paste "Definition of #{term}:\n\n" + definitions.join("\n\n")
  end
end

Poundie.use :urban_dictionary
