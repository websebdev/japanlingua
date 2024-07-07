module WordHelper
  def furigana(word)
    result = []
    content = word.content
    word.content.chars.map do |char|
      if char =~ /\p{Han}/
        first_part = content.split(char).first.to_s
        second_part = content.split(char).second.to_s
        hiragana = word.reading_hiragana.sub(first_part, "").sub(second_part, "")
        result.push("<ruby>#{char}<rt>#{hiragana}</rt></ruby>")
      else
        result.push(char)
      end
    end
    result.join.html_safe
  end

  private

  def kanji?(char)
    char =~ /\p{Han}/
  end
end
