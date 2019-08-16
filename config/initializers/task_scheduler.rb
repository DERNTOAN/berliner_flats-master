# frozen_string_literal: true
​
require 'rufus/scheduler'
​
scheduler = Rufus::Scheduler.new
​
scheduler.every '2m' do
  require 'nokogiri'
  require 'open-uri'
  require 'telegram/bot'
  sleep(rand(12))
  # doc = Nokogiri::HTML(open('https://www.immobilienscout24.de/Suche/S-2/Wohnung-Miete/Berlin/Berlin/Charlottenburg-Charlottenburg/3,00-/-/EURO--1500,00?enteredFrom=HNC_LAST_SEARCH'))
  # doc = Nokogiri::HTML(open("https://www.immobilienscout24.de/Suche/S-2/Wohnung-Miete/Polygonsuche/%7Bun_I%7Dg%7CoAuj@%7BKiSwg@_%7D@%7BmDSjD_N_tBne@ia@zDqs@tL%7D%5BvJwXvJal@~m@ybBlIucAlz@uf@dh@vI%7C%60A%7CZrRzi@zDrt@bHzkE__@hlAioAzaCup@hvC/3,00-/-/EURO--1200,00?enteredFrom=result_list#/"))
  doc = Nokogiri::HTML(open("https://www.immobilienscout24.de/Suche/S-2/Wohnung-Miete/Umkreissuche/Berlin/10625/221692/2510708/-/-/1/3,00-/-/EURO--1500,00?enteredFrom=HNC_LAST_SEARCH"))
  result = []
  doc.xpath("//ul[@id='resultListItems']//li[contains(@class, 'result-list__listing')]").each do |i|
    result << i.attributes['data-id'].value
  end
​
  result.each do |r|
    flat = Flat.where(immo_id: r)
    unless flat.present?
      # Info how to create new bot https://core.telegram.org/bots
      bot = Telegram.bot
      # !!! Put your Telegram group ID. You can create it in the Telegram app
      bot.send_message(chat_id: '-1001266627616', text: "https://www.immobilienscout24.de/#{r}")
      Flat.create(immo_id: r)
    end
  end
end
