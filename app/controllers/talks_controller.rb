class TalksController < ApplicationController

    before_action :authenticate_user!, only: [:new, :create]

    def index
      @talks= Talk.all
      @tags = Tag.all
      @talks = @talks.where("body LIKE ? ",'%' + params[:search] + '%') if params[:search].present?  

      #もしタグ検索したら、post_idsにタグを持ったidをまとめてそのidで検索
  if params[:tag_ids].present?
    talk_ids = []
    params[:tag_ids].each do |key, value| 
      if value == "1"
        Tag.find_by(name: key).talks.each do |p| 
          talk_ids << p.id
        end
      end
    end
    talk_ids = talk_ids.uniq
    #キーワードとタグのAND検索
    if talk_ids.present?
      @talks = @talks.where(id: talk_ids)
    else
      @talks = @talks.where(id: 0)
    end
  end

      if params[:tag]
        Tag.create(name: params[:tag])
      end

    end

    def new
        @talk = Talk.new
      end
    
      def create
        talk = Talk.new(talk_params)
        talk.user_id = current_user.id
        if talk.save!
          redirect_to :action => "index"
        else
          redirect_to :action => "new"
        end

      end

      def show
        @talk = Talk.find(params[:id])
      end
    
      def edit
        @talk = Talk.find(params[:id])
      end

      def update
        talk = Talk.find(params[:id])
        if talk.update(talk_params)
          redirect_to :action => "show", :id => talk.id
        else
          redirect_to :action => "new"
        end
      end

      def destroy
        talk = Talk.find(params[:id])
        talk.destroy
        redirect_to action: :index
      end

      private
      def talk_params
        params.require(:talk).permit(:title, :body, :user_name,tag_ids: [])
      end

end
