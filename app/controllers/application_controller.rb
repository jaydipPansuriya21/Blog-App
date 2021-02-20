class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception


  def hello
    render html: "Hello I am hello page ..."
  end
end
