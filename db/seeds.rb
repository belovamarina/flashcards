parse_words = ->(page) do
  page.xpath("//td[@id='middle']//tr").each do |row|
    original = row.xpath("td[2]").text[/(.+)\[/, 1]&.strip
    translated = row.xpath("td[3]").text.strip
    next if original.blank? || translated.blank?
    date = 3.days.from_now

    Card.create(
        original_text: original,
        translated_text: translated,
        review_date: date,
        user_id: 1,
        deck_id: rand(1..3)
    )
  end
end

page = Nokogiri::HTML(open("http://www.en365.ru/top1000.htm"))
parse_words.call(page)

# Pagination
if page.xpath("//h3[3]/a").present?
  page.xpath("//h3[3]/a").each do |a|
    page = Nokogiri::HTML(open("http://www.en365.ru/#{a[:href]}"))
    parse_words.call(page)
  end
end
