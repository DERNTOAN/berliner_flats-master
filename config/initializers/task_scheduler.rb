# frozen_string_literal: true

require 'rufus/scheduler'

scheduler = Rufus::Scheduler.new

scheduler.every '2m' do
  require 'nokogiri'
  require 'open-uri'
  require 'telegram/bot'
  sleep(rand(12))
  # doc = Nokogiri::HTML(open('https://www.immobilienscout24.de/Suche/S-T/Wohnung-Miete/Hamburg/Hamburg/Eimsbuettel_Eppendorf_Harvestehude_Hoheluft-Ost_Hoheluft-West_Ottensen_Rotherbaum_Sternschanze_Uhlenhorst_Winterhude/3,00-/100,00-/EURO--1800,00?enteredFrom=result_list'))
  # doc = Nokogiri::HTML(open("https://www.immobilienscout24.de/Suche/S-2/Wohnung-Miete/Polygonsuche/%7Bun_I%7Dg%7CoAuj@%7BKiSwg@_%7D@%7BmDSjD_N_tBne@ia@zDqs@tL%7D%5BvJwXvJal@~m@ybBlIucAlz@uf@dh@vI%7C%60A%7CZrRzi@zDrt@bHzkE__@hlAioAzaCup@hvC/3,00-/-/EURO--1200,00?enteredFrom=result_list#/"))
  doc = Nokogiri::HTML(open("https://www.immobilienscout24.de/Suche/S-T/Wohnung-Miete/Hamburg/Hamburg/Eimsbuettel_Eppendorf_Harvestehude_Hoheluft-Ost_Hoheluft-West_Ottensen_Rotherbaum_Sternschanze_Uhlenhorst_Winterhude/3,00-/100,00-/EURO--1800,00?enteredFrom=result_list"))
  result = []
  doc.xpath("//ul[@id='resultListItems']//li[contains(@class, 'result-list__listing')]").each do |i|
    result << i.attributes['data-id'].value
  end

  result.each do |r|
    flat = Flat.where(immo_id: r)
    unless flat.present?
      # Info how to create new bot https://core.telegram.org/bots
      bot = Telegram.bot
      # !!! Put your Telegram group ID. You can create it in the Telegram app
      bot.send_message(chat_id: '-327256881', text: "https://www.immobilienscout24.de/#{r}")
      Flat.create(immo_id: r)
    end
  end
end
