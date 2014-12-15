class ArticlesController < ApplicationController
	def new
		
	end

	def create
		# render plain: params[:article].inspect
		params.permit!
		@article = Article.new(params[:article])

		if @article.save
			redirect_to @article, notice: 'Article was succefully created.'
		else
			render action: 'new'
		end
	end

	private
	def article_params
		params.require(:article).permit(:title, :text)
	end
end
