class FavoritesController < ApplicationController
	def update
		pet = Pet.find(params[:pet_id])
		pet_id_str = pet.id.to_s
		session[:favorites] ||= []
		if session[:favorites].include?(pet_id_str)
			flash[:notice] = "#{pet.name} is already in your favorites! Yay!!!!!"
		else
			session[:favorites] << pet_id_str 
			flash[:notice] = "You have added #{pet.name} to your favorites! Yay!!!!!"
		end
		redirect_to "/pets/#{pet.id}"
	end
	
	def index
		@pets = Pet.find([session[:favorites]])
	end

	 def destroy
	    pet = Pet.find(params[:id])
		pet_id = pet.id.to_s
    		session[:favorites].delete(pet_id)
		redirect_back(fallback_location:"/pets")
  	end

end
