class HomeController < ApplicationController
  def index
    #search the make
    uri = URI("http://www.webmotors.com.br/carro/marcas")

    # Make request for Webmotors site
    response = Net::HTTP.post_form(uri, {})
    json = JSON.parse response.body

    # Itera no resultado e grava as marcas que ainda não estão persistidas
    ActiveRecord::Base.transaction do
      json.each do |row|
        make = Make.find_or_initialize_by(name: row["Nome"])
        if make.valid? && !make.webmotors_id
          make.webmotors_id = row["Id"]
          make.save
        end
      end
    end    
  end
end
