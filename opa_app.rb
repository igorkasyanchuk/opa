require "sinatra/content_for"

class OpaApp < Sinatra::Base
  helpers Sinatra::ContentFor

  set :root, File.dirname(__FILE__)

  register Sinatra::AssetPack

  enable :sessions
  enable :logging

  assets {
    serve '/js',     from: 'app/js'        # Default
    serve '/css',    from: 'app/css'       # Default
    serve '/images', from: 'app/images'    # Default

    js :application, '/js/application.js', [
      '/js/app.js'
    ]

    css :application, '/css/application.css', [
      '/css/screen.css'
    ]

    js_compression  :jsmin    # :jsmin | :yui | :closure | :uglify
    css_compression :simple   # :simple | :sass | :yui | :sqwish
  }  

  helpers do
    def h(text)
      Rack::Utils.escape_html(text)
    end

    def title(str)
      content_for :title do
        str
      end
    end
  end

  run! if app_file == $0

  get '/' do
    slim :index
  end
end