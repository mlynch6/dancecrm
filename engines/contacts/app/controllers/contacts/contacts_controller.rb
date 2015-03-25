require_dependency "contacts/application_controller"

module Contacts
  class ContactsController < ApplicationController
    def index
			@contacts = Person.scoped_to(current_account).paginate(page: params[:page], per_page: params[:per_page])
    end
		
		def new
			@person = Person.scoped_to(current_account).new
		end
		
		def create
			@person = Person.scoped_to(current_account).new(person_params)
			if @person.save
				flash[:success] = 'Your contact was successfully created.'
				redirect_to contacts.contacts_path
			else
				render :new
			end
		end
		
		def edit
			load_resource
		end
	
		def update
			load_resource
			if @person.update_attributes(person_params)
				flash[:success] = "#{@person.full_name} was successfully updated."
				redirect_to contacts_path
			else
				render :edit
			end
		end
	
		def destroy
			load_resource
			@person.destroy
			flash[:success] = "#{@person.full_name} was deleted."
			redirect_to contacts.contacts_path
		end
		
		private
		
		def person_params
			params.require(:person).permit(:first_name, :middle_name, :last_name, :suffix, 
					:gender, :birth_date_mdY, :email, :active)
		end
		
		def load_resource
			@person = Person.scoped_to(current_account).find(params[:id])
		rescue ActiveRecord::RecordNotFound
			redirect_to contacts_path, :notice => 'Record not found'
		end
  end
end
