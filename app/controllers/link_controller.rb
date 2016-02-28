class LinkController < ApplicationController
  before_action :set_link, only: [:show , :stats, :destroy]

  def index
      @link = Link.new
      @Shortened_urls = Shortened_urls.order(created_at: :desc)
  end
  
  def create
      @link = Link.new(link_params)
      if (@link.save)
        webcrawl
        redirect_to root_path
      else
        render 'index'
      end
  end 
  
  def show
    if params[:unique_key]
        if redirect_to @Shortened_urls.url
            @Shortened_urls.use_count += 1
            @Shortened_urls.save
        end
    else
      render 'index'
    end
  end
  
  def stats
    if params[:unique_key]
        @Stat = Stat.find_by(Shortened_urls_id:  @Shortened_urls.id)
    else
      render 'index'
    end
  end
  
  def destroy
    if params[:unique_key]
        @Shortened_urls.destroy 
    end
    
    redirect_to root_path
  end
  
  private
  
    def webcrawl
       # Create Stats
        @Shortened_urls = Shortened_urls.find_by(url: @link.longurl)
        Pettyjob.perform_async(@Shortened_urls.id)
    end

  
    # Use callbacks to share common setup or constraints between actions.
    def set_link
      @Shortened_urls = Shortened_urls.find_by(unique_key: params[:unique_key])
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def link_params
      params.require(:link).permit(:longurl)
    end
  
end
