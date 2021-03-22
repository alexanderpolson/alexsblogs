class AuthorsController < ApplicationController

  before_filter :require_login
  skip_before_filter :require_login, only: [:show]

  # GET /authors
  # GET /authors.json
  def index
    @authors = Author.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /authors/1
  # GET /authors/1.json
  def show
    @author = Author.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /authors/new
  # GET /authors/new.json
  def new
    @author = Author.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /authors/1/edit
  def edit
    @author = Author.find(params[:id])
  end

  # POST /authors
  # POST /authors.json
  def create
    @author = Author.new(params[:author])

    respond_to do |format|
      if @author.save
        format.html { redirect_to @author, notice: 'author was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /authors/1
  # PUT /authors/1.json
  def update
    @author = Author.find(params[:id])

    # If a new password wasn't specified then just use the old one. Since
    # a password field is used the edit form starts blank so we don't want
    # to delete the existing password.
    new_password = params[:author][:password]
    params[:author][:password] = @author.password if new_password.empty?

    respond_to do |format|
      if @author.update_attributes(params[:author])
        format.html { redirect_to @author, notice: 'author was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /authors/1
  # DELETE /authors/1.json
  def destroy
    @author = Author.find(params[:id])
    @author.destroy

    respond_to do |format|
      format.html { redirect_to authors_url }
      format.json { head :ok }
    end
  end
end
