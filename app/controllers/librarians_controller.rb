class LibrariansController < ApplicationController
  before_action :set_librarian, only: [:show, :edit, :update, :destroy]
  # skip_before_action :verify_authenticity_token
  after_action :verify_authorized
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

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

    respond_to do |format|
      if @librarian.save
        format.html { redirect_to @librarian, notice: 'Librarian was successfully created.' }
        format.json { render :show, status: :created, location: @librarian }
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
        format.html { redirect_to @librarian, notice: 'Librarian was successfully updated.' }
        format.json { render :show, status: :ok, location: @librarian }
      else
        format.html { render :edit }
        format.json { render json: @librarian.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /librarians/1
  # DELETE /librarians/1.json
  def destroy
    authorize Librarian
    @librarian.destroy
    respond_to do |format|
      format.html { redirect_to librarians_url, notice: 'Librarian was successfully destroyed.' }
      format.json { head :no_content }
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
