class DogsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create]
    def index 
        if params[:search] == nil  
          @dogs=Dog.all
        elsif params[:search] == ''
          @dogs=Dog.all
        else
          #部分検索
          @dogs = Dog.where("body LIKE ? ",'%' + params[:search] + '%')
        end

        @blogs = Blog.all

        @perfume = Perfume.new

        if params[:tag_ids]
          @dogs = []
          params[:tag_ids].each do |key, value|      
            if value == "1"
              tag_dogs = Tag.find_by(name: key).dogs
              @dogs = @dogs.empty? ? tag_dogs : @dogs & tag_dogs
            end
          end
        end 
        
        if params[:tag]
          Tag.create(name: params[:tag])
        end
    end

    def new
        @dog = Dog.new
    end
    
    def create
        dog = Dog.new(dog_params)
        dog.user_id = current_user.id 
        if dog.save!
          redirect_to :action => "index"
        else
          redirect_to :action => "new"
        end
    end

    def show
        @dog = Dog.find(params[:id])
        @comments = @dog.comments
        @comment = Comment.new
    end

    def edit
        @dog = Dog.find(params[:id])
    end

    def update
        dog = Dog.find(params[:id])
      if dog.update(dog_params)
          redirect_to :action => "show", :id => dog.id
        else
          redirect_to :action => "new"
      end
    end

    def destroy
        dog = Dog.find(params[:id])
        dog.destroy
        redirect_to action: :index
    end

    def calender
      @blogs = Blog.all
    end
    
      private
    def dog_params
        params.require(:dog).permit(:body,:image,:title, :content, :start_time,:youtube_url, tag_ids: [])
    end


  end 