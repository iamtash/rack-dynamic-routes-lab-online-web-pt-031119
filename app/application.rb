require 'pry'

class Application
  def call(env)
    req = Rack::Request.new(env)
    resp = Rack::Response.new

    if req.path.match(/items/)
      item_name = req.path.split('/items/').last
      item = @@items.find {|i| i.name == item_name}
      if item
        resp.write "#{item.price}"
        resp.status = 200
      else
        resp.write "Item not found"
        resp.status = 400
      end
    else
      resp.write "Route not found"
      resp.status = 404
    end

    resp.finish
  end
end
