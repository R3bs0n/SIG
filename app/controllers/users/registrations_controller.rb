module Users
  class RegistrationsController < Devise::RegistrationsController
    private

    def build_resource(hash = {})
      company_name = params.dig(:user, :company_name).presence || "Minha Empresa"
      company = Company.find_or_initialize_by(name: company_name)
      company.save! if company.new_record?
      super(hash.merge(company: company, role: "admin"))
    end

    def sign_up_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :company_name)
    end
  end
end
