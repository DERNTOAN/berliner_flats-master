# frozen_string_literal: true

desc 'Fetch new tasks from immoscout'
task fetch_new_flats: :environment do
  log = ActiveSupport::Logger.new('log/fetch_new_flats.log')
  start_time = Time.now

  sleep(rand(12))

  log.info "Task started at #{start_time}"
  doc = Nokogiri::HTML(open('https://www.immobilienscout24.de/Suche/S-T/Wohnung-Miete/Hamburg/Hamburg/Eimsbuettel_Eppendorf_Harvestehude_Ottensen_Rotherbaum_Uhlenhorst_Winterhude/3,00-/100,00-/EURO--1800,00?enteredFrom=result_list'))
  result = []
  doc.xpath("//ul[@id='resultListItems']//li[contains(@class, 'result-list__listing')]").each do |i|
    result << i.attributes['data-id'].value
  end

  result.each do |r|
    flat = Flat.where(immo_id: r)
    unless flat.present?
      log.info r
      bot = Telegram.bot
      bot.send_message(chat_id: '-327256881', text: "https://www.immobilienscout24.de/#{r}")
      Flat.create(immo_id: r)
    end
  end

  end_time = Time.now
  duration = (end_time - start_time)
  log.info "Task finished at #{end_time} and last #{duration} seconds."
  log.close
end
