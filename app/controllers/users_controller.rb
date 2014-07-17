class UsersController < ApplicationController

def create
p params["first_name"]

greg = User.create(first_name:params["first_name"],last_name:params["last_name"],email:params["email"],password: params["password"],password_confirmation:params["password_confirmation"])
p greg
end

private
def user_params
params.require(:user).permit(:first_name,:last_name,:email,:password,:password_confirmation)

end

end