# coding: utf-8

module Trans
  require 'cgi'
  require './open-uri-post.rb'
  require 'rexml/document'
  require 'json'

  CLIENT_ID       = 'miyake_flower'
  CLIENT_SECRET   = 'stA5rg2dh+cg19yfjILAKos/pf/K+P8B6rIa6ityR2o='
  AUTHORIZE_URL   = 'https://datamarket.accesscontrol.windows.net/v2/OAuth2-13'
  TRANSLATION_URL = 'http://api.microsofttranslator.com/V2/Http.svc/Translate'
  SCOPE           = 'http://api.microsofttranslator.com'

  def translate_text(text)
    @@access_token ||= get_access_token

    res = open("#{TRANSLATION_URL}?from=ja&to=en&text=#{URI.escape(text)}",
               'Authorization' => "Bearer #{@@access_token}").read
    xml = REXML::Document.new(res)
    xml.root.text
  end
  module_function :translate_text

  private

  def self.get_access_token
    access_token = nil
    open(AUTHORIZE_URL,
         'postdata' => "grant_type=client_credentials&client_id=#{CGI.escape(CLIENT_ID)}&client_secret=#{CGI.escape(CLIENT_SECRET)}&scope=#{CGI.escape(SCOPE)}") do |f|
      json           = JSON.parse(f.read)
      access_token   = json['access_token']
    end
    access_token
  end
end

puts Trans.translate_text("コスモス")
