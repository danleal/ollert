class Ollert
  get '/privacy', :auth => :none do
    haml :privacy
  end

  get '/terms', :auth => :none do
    haml :terms
  end
end
