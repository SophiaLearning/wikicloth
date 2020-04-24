# frozen_string_literal: true

module WikiCloth
  class PoemExtension < Extension

    # <poem>poem content (to preserve spacing)</poem>
    #
    element 'poem' do |buffer|
      content = buffer.element_content
                      .gsub(/\A\n/,"") # remove new line at beginning of string
                      .gsub(/\n\z/,"") # remove new line at end of string
                      .gsub(/^\s+/) { |m| "&nbsp;" * m.length } # replace all spaces at beginning of line with &nbsp;
                      .gsub(/\n/,'<br />') # replace all new lines with <br />
      "<div class=\"poem\">#{content}</div>"
    end

  end
end
