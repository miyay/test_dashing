# coding: utf-8
require "open-uri"

array = ["blue", "red", "green"]

SCHEDULER.every '10s' do
  # send_event('sample_count', { value: rand })
  send_event('sample_num', { current: rand(100), last: 100, color: array.sample, hoge: rand(100) })
end
