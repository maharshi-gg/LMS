class RegistrationsController < Devise::RegistrationsController

  def create

    # @user = User.new(sign_up_params)
    # @user.save
    # respond_to do |format|
    if sign_up_params[:role]=='user'
        @stud = Student.find_by_email(sign_up_params[:email])
        if @stud.nil?
          @stud = Student.new(email: sign_up_params[:email], name: params[:user][:student][:name],
                              password: sign_up_params[:password], education: params[:user][:student][:education],
                              university: params[:user][:student][:university], max_books: params[:user][:student][:max_books])
          @stud.save
        else
          # @stud.update(student_signup_params)
          # format.html { redirect_to students_path, notice: 'Student was successfully created.' }
          # format.json { render :show, status: :created, location: @student }
        end
      elsif sign_up_params[:role]=='librarian'
        @lib = Librarian.find_by_email(sign_up_params[:email])
        if(@lib.nil?)
          @lib = Librarian.new(email: sign_up_params[:email], name: params[:user][:librarian][:name],
                               password: sign_up_params[:password], libraries_id: params[:user][:librarian][:libraries_id])
          @lib.save
        else
          @lib.update(librarian_signup_parmas)
          # format.html { redirect_to librarians_path, notice: 'Student was successfully created.' }
          # format.json { render :show, status: :created, location: @librarian }
        end
    end
    super and return
    # if @user.save
    #   format.html { redirect_to @user, notice: 'Student was successfully created.' }
    #   format.json { render :show, status: :created, location: @user }
    #  else
    #   format.html { render :new }
    #   format.json { render json: @user.errors, status: :unprocessable_entity }
    # end
    # end
  end

  private
  def sign_up_params 
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :role,
                                 student_attributes: [:email, :name, :password, :education, :university, :max_books],
                                 librarian_attributes: [:email, :name, :password, :libraries_id])
  end
  def account_update_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password)
  end

end
