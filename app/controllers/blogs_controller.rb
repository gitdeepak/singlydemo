class BlogsController < ApplicationController
  def post_to_api
    if params[:title] 
      json = 'data={"Title": "%s","Text": "%s","Author": {"Name": "%s","Email": "someone@example.com"}, "Tags": ["hack"]}' % [params[:title], params[:text], params[:author]]
      @result = HTTParty.post('http://api.easyapi.co/endpoints/instance/create?blueprintname=blogpost', 
          :body =>  json ,
          :headers => { 'Content-Type' => 'application/x-www-form-urlencoded' } ) 
          
      #render :json => @result           
    end      
  end    
  
  def get_singly
    @response = HTTParty.get('https://api.singly.com/types/news_feed?limit=4&access_token=DtzR-tRejN5mSQ771KpH3Ovt_H8.FgkymY5R3dc89b0ea6788a4173623a307cd815fb0bc1be04aedaf75add36779e9ccc4ceed35808305b0670e9a619705485cbc97ff6b49f66fc719803139459d3b0b42ebffd05d79809d56f315cad1a9bb20d9fc0711daaee89a0e4e82325ff46d7f4ff5f')
    
    #puts @response.body, @response.code, @response.message, @response.headers.inspect



    @response.each do |item|
      text = item['data']['text']
      name = item['data']['user']['name']

      json = 'data={"Title": "%s","Text": "%s","Author": {"Name": "%s","Email": "someone@example.com"}, "Tags": ["hack"]}' % ['Twiter via Singly', text, name]
      @result = HTTParty.post('http://api.easyapi.co/endpoints/instance/create?blueprintname=blogpost', 
          :body =>  json ,
          :headers => { 'Content-Type' => 'application/x-www-form-urlencoded' } ) 
    end
    #@data = JSON.parse response
    
    #@data = @response['blogpost']
    #render :json => @response
    redirect_to "/"
  end  
end


