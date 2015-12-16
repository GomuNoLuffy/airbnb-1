class ListingsController < ApplicationController

	def new
		@listing = current_user.listings.new
	end

	def edit
		@listing = Listing.find(params[:id])
	end

	def update
		@listing = Listing.find(params[:id])
		if @listing.update(listing_params)
			redirect_to @listing
		else
			render 'edit'
		end
	end

	def create
		@listing = current_user.listings.new(listing_params)
		if @listing.save
			
  			redirect_to @listing
  		else
  			render 'new'
  		end
	end
	
	def show
		@listing = Listing.find(params[:id])
		@user = User.find(@listing.user_id)
	end

	def index
		@listings = Listing.all
	end

	def destroy
		@listing = Listing.find(params[:id])
		@listing.destroy
		redirect_to listings_path
	end

	def tagged
	  if params[:tag].present? 
	    @listings = List.tagged_with(params[:tag])
	  else 
	    @listings = List.postall
	  end  
	end

private     
	def listing_params
		params.require(:listing).permit(:name,:body, :start, :end, :price, :num_of_guest, :room_type, :tag_list, :address_street_number, :address_street, :address_city, :address_zip_code, :address_state, :address_country, {picture: []})
	end 
end

