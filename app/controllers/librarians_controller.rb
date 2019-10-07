class LibrariansController < ApplicationController
  before_action :set_librarian, only: [:show, :edit, :update, :destroy]
  # skip_before_action :verify_authenticity_token
  after_action :verify_authorized
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  helper_method :approve_book_request


  # GET /librarians
  # GET /librarians.json
  def index
    # @user = Librarian.find(params[:id])
    # unless current_user.librarian?
    #   unless @user == current_user
    #     redirect_to :back, :alert => "Access denied!"
    #   end
    # end
    # @users = Librarian.all
    # @my_models = policy_Scope(MyModel)
    @librarians = policy_scope(Librarian)
    @librarians = Librarian.all

    @library_dict = {}
    @libs = Library.all

    @libs.each do |l|
      @library_dict[l.id] = l.name
    end

    authorize Librarian
  end

  # GET /librarians/1
  # GET /librarians/1.json
  def show
    # @user = Librarian.find(params[:id])
    # unless current_user.librarian?
    #   unless @user == current_user
    #     redirect_to :back, :alert => "Access denied!"
    #   end
    # end
    # @users = Librarian.all
    authorize Librarian
    # @user = User.find(params[:id])
    # unless current_user.librarian?
    #   unless @user == current_user
    #     redirect_to user_homepage, :alert => "Access denied!"
    #   end
    # end
  end

  # GET /librarians/new
  def new
    @librarian = Librarian.new
    authorize Librarian
  end

  # GET /librarians/1/edit
  def edit
    authorize Librarian
  end

  # POST /librarians
  # POST /librarians.json
  def create
    authorize Librarian
    @librarian = Librarian.new(librarian_params)

    # create user entry here
    puts librarian_params

    respond_to do |format|
      if @librarian.save
        format.html { redirect_to user_homepage_path, notice: 'Request sent to Admin was authorisation.' }
        format.json { render :show, status: :created, location: user_homepage_path }
      else
        format.html { render :new }
        format.json { render json: @librarian.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /librarians/1
  # PATCH/PUT /librarians/1.json
  def update
    authorize Librarian
    respond_to do |format|
      if @librarian.update(librarian_params)
        @user = User.find_by_email(current_user.email)
        @user.update({email: @librarian.email})
        format.html { redirect_to librarians_url, notice: 'Librarian was successfully updated.' }
        format.json { render :show, status: :ok, location: @librarian }
      else
        format.html { render :edit }
        format.json { render json: @librarian.errors, status: :unprocessable_entity }
      end
    end
  end

  def list_special_book_request
    authorize Librarian
    query = "select * from book_request"
    #@book_request = BookRequest.find(query)
    @book_request = BookRequest.all.where(is_approved: 'false')
  end

  def approve_book_request
    authorize Librarian
    @book_request = BookRequest.find(params[:id])
   # query = "update book_request"
    @book_request.update_attribute(:is_approved,"true")
  end

  # DELETE /librarians/1
  # DELETE /librarians/1.json
  def destroy
    authorize Librarian
    # @librarian.destroy
    respond_to do |format|
      if @librarian.destroy
        format.html { redirect_to librarians_url, notice: 'Librarian was successfully destroyed.' }
        format.json { head :no_content }
      else
        format.html {redirect_to librarian_url, alert: 'Librarian was not successfully destroyed.'}
      end
    end
  end

  def copy_data
    if self.librarian?


      @user = User.find(self.id)
      if Librarian.find_by_email(self.email).nil?
        @lib = Librarian.new(email: self.email, password: self.encrypted_password, libraries_id: 1)
        @lib.save
        #   flash[:success] = "Successfully saved data to Librarian model"
        # redirect_to librarians_path

        # else
        #   flash[:error] = "Could not create record"
        # end
      end

      # @user = Librarian.find(self.id)
      # if (nil == @user)
      #   @lib = Librarian.create(email: self.email, name:self.email, password: self.encrypted_password, users_id: self.id)
      #   @lib.save
      # else
      #   @lib = Librarian.create(email: self.email, name:self.email, password: self.encrypted_password, users_id: self.id)
      #   @lib.save
      # end
      #
    elsif self.user?
      # @user = User.find(self.id)
      if Student.find_by_email(self.email).nil?
        @stud = Student.new(email: self.email, password: self.encrypted_password)
        @stud.save
        #   flash[:success] = "Successfully saved data to Student model"
        # redirect_to students_path
        # else
        #   flash[:error] = "Could not create record"
        # end
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_librarian
      @librarian = Librarian.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def librarian_params
      params.require(:librarian).permit(:email, :name, :password, :libraries_id)
    end

    def user_not_authorized
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to(request.referrer || root_path)
    end
end
