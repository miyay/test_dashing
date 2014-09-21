# coding: utf-8↲

require "open-uri"
require "nokogiri"
require "pp"

t = Time.now

html = open("http://www.okuru-hana.com/40/post_22.html").read
doc = Nokogiri::HTML.parse(html, nil, nil)
days = doc.css(".entry-body p")

array = days.map do |day|
  day.text.split("\n").delete_if{|k| k.empty?}.map do |m|
    parse = m.match(/^(?<day>.*)\t\t(?<flower>.*)・・・(?<word>.*)/)
    {day: parse[:day], flower: parse[:flower], word: parse[:word]}
  end
end

pp array.flatten.group_by{|i| i[:day]}["#{t.month}月#{t.day}日"]
