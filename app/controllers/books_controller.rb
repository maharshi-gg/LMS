class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  # GET /books
  # GET /books.json
  def index
    @books = if (params[:search_by_title] || params[:search_by_author] || params[:search_by_subject] || params[:search_by_published_before] || params[:search_by_published_after])
               if (params[:search_by_published_before]!="" && params[:search_by_published_after]!="")
                 Book.where('lower(title) LIKE ? and lower(author) LIKE ? and lower(subject) LIKE ? and published > ? and published < ?', "%#{params[:search_by_title].downcase}%","%#{params[:search_by_author].downcase}%","%#{params[:search_by_subject].downcase}%","#{params[:search_by_published_before]}","#{params[:search_by_published_after]}")
               elsif (params[:search_by_published_before]!="")
                 Book.where('lower(title) LIKE ? and lower(author) LIKE ? and lower(subject) LIKE ? and published < ?', "%#{params[:search_by_title].downcase}%","%#{params[:search_by_author].downcase}%","%#{params[:search_by_subject].downcase}%","#{params[:search_by_published_before]}")
               elsif (params[:search_by_published_after]!="")
                 Book.where('lower(title) LIKE ? and lower(author) LIKE ? and lower(subject) LIKE ? and published > ?', "%#{params[:search_by_title].downcase}%","%#{params[:search_by_author].downcase}%","%#{params[:search_by_subject].downcase}%" ,"#{params[:search_by_published_after]}")
               else
                 Book.where('lower(title) LIKE ? and lower(author) LIKE ? and lower(subject) LIKE ?', "%#{params[:search_by_title].downcase}%","%#{params[:search_by_author].downcase}%","%#{params[:search_by_subject].downcase}%")
               end
             else
               Book.all
             end
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    # render plain: params[:book].inspect

    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end


  def search
    if params[:search].blank?
      redirect_to(root_path, alert: "Empty field!") and return
    else
      @parameter = params[:search].downcase
      @results = Book.all.where("lower(title) LIKE :search", search: @parameter)
      end

  end

  def book_request
    @book = Book.find(params[:id])
    @student = Student.find_by_email(current_user.email)
    if(@book.special_collection == "true")
        @is_approved_1 = false
    else @is_approved_1 = true
    end
    @req = BookRequest.find_by_sql(["select * from book_request where students_id = ? AND books_id = ?",@student.id,@book.id])
    if @req.nil?
    query = "INSERT INTO book_request (date,is_special,is_approved,books_id, students_id) VALUES
                                      ('#{Date.today}','#{@book.special_collection}','#{@is_approved_1}','#{@book.id}','#{@student.id}')"
    BookRequest.connection.execute(query)
      redirect_to(@book_requests_path, notice: "list of all books collected.")
    else redirect_to(root_path, alert: "already requested or collected.");
    end
  end

  helper_method :book_request
  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def add_details

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:title, :isbn, :author, :language, :published, :edition, :subject, :summary, :special_collection, :book_count, :libraries_id, :search)
      # params.fetch(:book, {})
    end
end
