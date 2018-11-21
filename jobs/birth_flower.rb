# coding: utf-8
require "open-uri"
require "nokogiri"
require "time"

html = open("http://www.okuru-hana.com/40/post_22.html").read
doc = Nokogiri::HTML.parse(html, nil, nil)
days = doc.css(".entry-body p")

array = days.map do |day|
  day.text.split("\n").delete_if{|k| k.empty?}.map do |m|
    parse = m.match(/^(?<day>.*)\t\t(?<flower>.*)・・・(?<word>.*)/)
    {day: parse[:day], flower: parse[:flower], word: parse[:word]}
  end
end

SCHEDULER.every '10s' do
  flower_counts = Hash.new({ value: 0 })

#  t = Time.now
  t = Time.parse("9/#{rand(29)+1}")
  today_flower = array.flatten.group_by{|i| i[:day]}["#{t.month}月#{t.day}日"]

  today_flower.each do |t|
    flower_counts[t[:flower]] = { label: t[:flower], value: t[:word]}
  end
  title = "Birth flower #{t.strftime("%m.%d(%a)")}"

  send_event('birth_flower', { title: title, items: flower_counts.values })
end
