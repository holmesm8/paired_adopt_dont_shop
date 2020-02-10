class ApplicationsController < ApplicationController
  def new
    @pets = Pet.find([session[:favorites]])
  end

  def create
    application = Application.new(app_params)
    if application.save
      pets = Pet.find(params[:pets])
      application.app_pet_add(pets)
      params[:pets].each{|pet_id| session[:favorites].delete(pet_id)}
      flash[:notice] = "Your application has been submitted for #{application.pets.map{|pet| pet.name}.join(", ")}! "
      redirect_to "/favorites"
    else
      flash[:notice] = "Fields required: Name, Address, City, State, Zip, Phone Number, Description"
      redirect_back(fallback_location:"/applications/new")
    end
  end

  private

  def app_params
    params.permit(
        :name,
          :address,
            :city,
              :state,
                :zip,
                  :phone,
                    :description)
  end
end