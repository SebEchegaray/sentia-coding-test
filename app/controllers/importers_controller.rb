class ImportersController < ApplicationController
  def index
  end

  def import
    require 'csv'

    csv_text = params[:file].read
    csv = CSV.parse(csv_text, headers: true)

    csv.each do |row|
      if row['Name'].present?
        person_name = row['Name'].split
        first_name = person_name.first
        last_name = person_name.size > 1 ? person_name[1..].join(" ") : nil

        person = Person.new(
          first_name: first_name,
          last_name: last_name,
          species: row['Species'],
          gender: row['Gender'],
          weapon: row['Weapon'],
          vehicle: row['Vehicle']
        )

        location = Location.find_or_create_by(name: row['Location'].titlecase)

        affiliation_name = row['Affiliations']&.titlecase
        affiliation = Affiliation.find_or_create_by(name: affiliation_name) if affiliation_name.present?

        person.locations << location
        person.affiliations << affiliation if affiliation.present?

        person.save
      end
    end

    redirect_to people_path
  end
end
