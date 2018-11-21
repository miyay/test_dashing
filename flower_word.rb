# coding: utf-8↲

require "open-uri"
require "nokogiri"
require "pp"
require "pry"

hoge = []

{
  1 => "http://www.okuru-hana.com/40/post_12.html",
  2 => "http://www.okuru-hana.com/40/post_15.html",
  3 => "http://www.okuru-hana.com/40/post_16.html",
  4 => "http://www.okuru-hana.com/40/post_17.html",
  5 => "http://www.okuru-hana.com/40/post_18.html",
  6 => "http://www.okuru-hana.com/40/post_19.html",
  7 => "http://www.okuru-hana.com/40/post_20.html",
  8 => "http://www.okuru-hana.com/40/post_21.html",
  9 => "http://www.okuru-hana.com/40/post_22.html",
  10 => "http://www.okuru-hana.com/40/post_23.html",
  11 => "http://www.okuru-hana.com/40/post_24.html",
  12 => "http://www.okuru-hana.com/40/post_25.html",
}.each_pair do |mon, url|
  html = open(url).read
  doc = Nokogiri::HTML.parse(html, nil, nil)
  days = doc.css(".entry-body p")

  puts "*****************************************"
  puts "#{mon}"
  puts "*****************************************"

  array = days.map do |day|
    day.text.split("\n").delete_if{|k| k.gsub(/\t/, "").empty?}.map do |m|
      parse = m.match(/^(?<day>.*)(\t\t|\t)(?<flower>.*)(・・・|・・)(?<word>.*)/)
      {day: parse[:day].gsub("\t", ""), flower: parse[:flower].gsub("・", ""), word: parse[:word].gsub(/(　| )/, "")}
    end
  end

  hoge << {mon => array.flatten.group_by{|d| d[:day]}}
end

open("flower_word.txt", "w") {|f| f.write hoge.to_yaml}
