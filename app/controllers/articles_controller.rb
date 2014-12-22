# encoding: utf-8

class ArticlesController < ApplicationController
	# http_basic_authenticate_with name: 'ddd', password: '123', except: [:index, :show]
	http_basic_authenticate_with name: 'ddd', password: '123', only: :destroy
	def index
		@articles = Article.all
	end

	def new
		# puts "koby"
		@article = Article.new # @article.errors.any? would not throw an error
	end

	def create
		# render plain: params[:article].inspect
		# 这边因为创建article对象，需使用安全方法，防范非法属性写入
		# puts "<<<<<"
		# p params #可以打印出params对象
		@article = Article.new(article_params) #params[:article],会报ActiveModel::ForbiddenAttributesError

		if @article.save
			redirect_to @article, notice: 'Article was succefully created.'
			
			# @articles = Article.all
			# render 'index'#, :id => @article.id
		else
			render 'new' # or render action: 'new'
			#render method is used so that the @article obj is passed back to the new template when it is rendered. This rednering is done within the same request as the form submission,
			#whereas the redirect_to will tell the browser to issue another request
		end
	end

	def show
		@article = Article.find(params[:id])
	end

	def edit
		@article = Article.find(params[:id])
	end

	def update
		@article = Article.find(params[:id])

		if @article.update(article_params)
			redirect_to @article
		else
			render 'edit'
		end
	end

	def destroy
		@article = Article.find(params[:id])
		@article.destroy

		redirect_to articles_path
	end

	private
	def article_params
		# require + the params key
		params.require(:article).permit(:title, :text)
	end
end
