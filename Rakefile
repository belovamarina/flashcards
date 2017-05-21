# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

namespace :export do
  desc 'Parse words for seeds.rb'
  task parse: :environment do
    begin
      page = request_page('http://www.en365.ru/top1000.htm')
      parse_words(page)

      # Pagination
      request_next(page) if page.xpath("//h3[3]/a").present?

    rescue StandardError => e
      puts "# #{e.message}"
    end
  end
end

private

def request_page(url)
  Nokogiri::HTML(open(url))
end

def parse_words(page)
  page.xpath("//td[@id='middle']//tr[position()>1]").each do |row|
    original = row.xpath("td[2]").text[/(.+)\[/, 1]&.strip
    translated = row.xpath("td[3]").text.strip
    next if original.blank? || translated.blank?
    date = Date.today + 3.days
    puts "Card.create(original_text: '#{original}', translated_text: '#{translated}', review_date: '#{date}')"
  end
end

def request_next(page)
  page.xpath("//h3[3]/a").each do |a|
    parse_words(request_page("http://www.en365.ru/#{a[:href]}"))
  end
end
