class Pettyjob
  include Sidekiq::Worker

  def perform(id)
    shortened_url = Shortened_urls.find(id)
    agent = Mechanize.new
    page = agent.get(shortened_url.url)
    httpheader = agent.head(shortened_url.url)
    
        
    # Create Stats
    @Stat = Stat.new
    @Stat.Shortened_urls_id = id
    @Stat.title = page.title
    @Stat.httpstatus = httpheader.code.to_i
    @Stat.save
    
  end
end
