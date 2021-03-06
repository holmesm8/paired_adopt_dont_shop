class SheltersController < ApplicationController
  def index
    @shelters = Shelter.all
  end

  def new
  end

  def create
    shelter = Shelter.new({
      name: params[:name],
      address: params[:address],
      city: params[:city],
      state: params[:state],
      zip: params[:zip]
      })

    if shelter.save
	redirect_to '/shelters'
    else
	flash[:error] = shelter.errors.full_messages.to_sentence
	redirect_to '/shelters/new'
    end
  end

  def show
    @shelter = Shelter.find(params[:id])
  end

  def edit
    @shelter = Shelter.find(params[:id])
  end

  def update
    shelter = Shelter.find(params[:id])
    shelter.update({
      name: params[:name],
      address: params[:address],
      city: params[:city],
      state: params[:state],
      zip: params[:zip]
      })

	if shelter.save
	    redirect_to "/shelters/#{shelter.id}"
	else
		flash[:error] = shelter.errors.full_messages.to_sentence
		redirect_back(fallback_location:"/shelters")
	end
  end

  def destroy
    pets_status = Shelter.find(params[:id]).pets.map {|pet| pet.adoptable}
    pets_status.delete("yes")
    if pets_status.empty?
      Shelter.destroy(params[:id])
      redirect_to '/shelters'
    else
      flash[:notice] = "Unable to delete shelter with an approved application"
      redirect_back(fallback_location:"/")
    end
  end
end
