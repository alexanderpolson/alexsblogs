require 'rexml/document'

class ArticlesController < ApplicationController
  include ActionView::Helpers::SanitizeHelper
  before_filter :require_login
  
  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.order('created_at DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @articles }
    end
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    @article = Article.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @article }
    end
  end

  # GET /articles/new
  # GET /articles/new.json
  def new
    @article = Article.new
    @blogs = Blog.all

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @article }
    end
  end

  # GET /articles/1/edit
  def edit
    @article = Article.find(params[:id])
    @blogs = Blog.all
  end

  # POST /articles
  # POST /articles.json
  def create
    import = params[:article][:import]
    if(import)
      author = Author.first
      xml = REXML::Document.new(import.read)

      xml.elements.each('rss/channel/item') do |item|
        article = Article.new
        item.elements.each('title') do |title|
          article.title = title.text
        end
        item.elements.each('content:encoded') do |body_el|
          body = body_el.text
          
          # Make sure that there's break between paragraphs
          body.sub!('</p>', "</p>\n")
          
          # Remove all tags that aren't links or images
          body = sanitize(body, tags: %w(a img))
          
          # Remove all blank lines
          body.gsub!(/^$\n/, '')
          article.body = body
        end
        item.elements.each('category') do |category|
          tag = Tag.new
          tag.name = category.attribute('nicename').value
          article.tags << tag
        end
        article.is_draft = true
        article.author = author
        article.blogs << Blog.first
        article.save
        item.elements.each('wp:post_date') do |post_date|
          article.created_at = Time.parse(post_date.text)
        end
        article.save
      end
    else
      @article = Article.new(params[:article])
      @article.author_id = current_author_id

      respond_to do |format|
        if @article.save
          format.html { redirect_to @article, notice: 'Article was successfully created.' }
          format.json { render json: @article, status: :created, location: @article }
        else
          format.html { render action: "new" }
          format.json { render json: @article.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PUT /articles/1
  # PUT /articles/1.json
  def update
    @article = Article.find(params[:id])

    respond_to do |format|
      if @article.update_attributes(params[:article])
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    respond_to do |format|
      format.html { redirect_to articles_url }
      format.json { head :ok }
    end
  end
end
