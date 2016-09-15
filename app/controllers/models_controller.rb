class ModelsController < ApplicationController
  def index
    #search the models
    uri = URI("http://www.webmotors.com.br/carro/modelos")

    # Make request for Webmotors site
    make = Make.where(webmotors_id: params[:webmotors_make_id])[0]

    response = Net::HTTP.post_form(uri, { marca: params[:webmotors_make_id] })
    json = JSON.parse response.body

    # Itera no resultado e grava os modelos que ainda não estão persistidas
    ActiveRecord::Base.transaction do
      json.each do |row|
        Model.find_or_create_by(name: row["Nome"], make_id: make.id)
      end
    end
  end
end
