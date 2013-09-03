# NPR delivers their content in UTF-8 formatting,
# but Net::HTTP doesn't convert the encoding automatically.
class ForceEncoding < Faraday::Middleware
  def call(env)
    @app.call(env).on_complete do
      if env[:body]
        env[:body] = env[:body].force_encoding('UTF-8')
      end
    end
  end
end
