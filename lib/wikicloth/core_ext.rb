# frozen_string_literal: true

# begin
#   require 'rinku'
# rescue LoadError
  require 'twitter-text'
  require 'nokogiri'
  require 'htmlentities'
# end

READ_MODE = "r:UTF-8"

module ExtendedString
  def blank?
    respond_to?(:empty?) ? empty? : !self
  end

  # if defined? Rinku
  #   def auto_link
  #     Rinku.auto_link(to_s)
  #   end
  # else
    def auto_link
      doc = Nokogiri::HTML::DocumentFragment.parse(to_s)
      doc.xpath(".//text()").each do |node|
        autolink = Twitter::Autolink.auto_link_urls(node.to_s, :suppress_no_follow => true, :target_blank => false)
        autolink = HTMLEntities.new.decode(autolink) if node.parent.name == "pre"
        node.replace autolink
      end
      doc.to_s
    end
  # end
end
