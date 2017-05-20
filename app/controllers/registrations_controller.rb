class RegistrationsController < Devise::RegistrationsController
  prepend_before_action :set_minimum_password_length, only: [:new, :edit]
  prepend_before_action :require_no_authentication, only: [:new, :create, :cancel]

  # GET /resource/sign_up
  def new
    build_resource({})
    yield resource if block_given?
    respond_with resource
  end

  # POST /resource
  def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      @organisation = Organisation.new
      @organisation.user_id = resource.id
      @organisation.save!(:validate => false)
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  def sign_up_params
    devise_parameter_sanitizer.sanitize(:sign_up)
  end


protected

  # def after_sign_up_path_for(resource)
  #   edit_profile_path(resource.profile)
  # end

  # def after_inactive_sign_up_path_for(resource)
  #   edit_profile_path(resource.profile)
  # end

private

  def sign_up_params
    params.require(:user).permit(:category, :email, :password, :password_confirmation)
  end

end