class PeopleController < ApplicationController
  def index
    @people = Person.includes(:locations, :affiliations)
    sort_options = {
      "first_name" => :first_name,
      "last_name" => :last_name,
      "species" => :species,
      "gender" => :gender,
      "weapon" => :weapon,
      "vehicle" => :vehicle,
      "locations.name" => "locations.name",
      "affiliations.name" => "affiliations.name",
      nil => :created_at
    }

    sort_by = sort_options[params[:sort]]

    @people = if sort_by.is_a?(Symbol)
                @people.order(sort_by => :asc)
              elsif sort_by
                @people.joins(sort_by.split(".")[0].to_sym).order(sort_by => :asc)
              else
                @people.order(created_at: :asc)
              end

    if params[:search].present?
      search_term = params[:search]
      @people = @people.where("people.first_name LIKE :search OR people.last_name LIKE :search OR people.species LIKE :search OR people.gender LIKE :search OR people.weapon LIKE :search OR people.vehicle LIKE :search OR locations.name LIKE :search OR affiliations.name LIKE :search", search: "%#{search_term}%").references(:locations, :affiliations)
    end

    @people = @people.paginate(page: params[:page], per_page: 10)
  end
end
