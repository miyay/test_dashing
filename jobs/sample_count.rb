# coding: utf-8
require "open-uri"

body = open("https://dl.dropboxusercontent.com/u/19230550/sample").read

SCHEDULER.every '10s' do
  send_event('sample_count', { value: body })
  send_event('sample_num', { current: body, last: 100 })
end
