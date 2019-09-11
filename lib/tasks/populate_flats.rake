# frozen_string_literal: true

desc 'Populate flats table with data'
task populate_flats: :environment do
  # log = ActiveSupport::Logger.new('log/populate_flats.log')
  start_time = Time.now

  # log.info "Task started at #{start_time}"
  doc = Nokogiri::HTML(open('https://www.immobilienscout24.de/Suche/S-T/Wohnung-Miete/Hamburg/Hamburg/Eimsbuettel_Eppendorf_Harvestehude_Hoheluft-Ost_Hoheluft-West_Ottensen_Rotherbaum_Sternschanze_Uhlenhorst_Winterhude/3,00-/100,00-/EURO--1800,00?enteredFrom=result_list'))
  last_page = doc.xpath("//select[contains(@aria-label, 'Seitenauswahl')]")
                 .children.last&.text
  pages_amount = last_page.present? ? last_page.to_i : 1
  pages_amount.times do |p|
    page = Nokogiri::HTML(open("https://www.immobilienscout24.de/Suche/S-T/P-#{p + 1}/Wohnung-Miete/Hamburg/Hamburg/Eimsbuettel_Eppendorf_Harvestehude_Ottensen_Rotherbaum_Uhlenhorst_Winterhude/3,00-/100,00-/EURO--1800,00?enteredFrom=result_list"))
    page.xpath("//ul[@id='resultListItems']//li[contains(@class, 'result-list__listing')]").each do |i|
      Flat.create(immo_id: i.attributes['data-id'].value)
    end
  end

  end_time = Time.now
  duration = (end_time - start_time)
  # log.info "Task finished at #{end_time} and last #{duration} seconds."
  # log.close
end
