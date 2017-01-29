require 'pry'
class BikeShareApp < Sinatra::Base

  get "/" do
    erb :"home/home"
  end

  get "/stations" do
    @stations = Station.all
    erb :"stations/index"
  end

  get "/stations/new" do
    ## if you want to have the user select city, installation date, and/or block count with a drop down, add instance variables like the one below.
    ## @cities = City.all.order(:name)
    erb :"stations/new"
  end

  post "/stations" do
    ## if you want to have the user select city, installation date, and/or block count with a text field,
    ##     you must create a new object or find an existing object with the data the user entered and then replace that text with the id in the parameters to create the station
    ##     params[:city] = City.find_or_create_by(name: params[:city]).id
    @station = Station.create(params[:station])
    redirect "/stations/#{@station.id}"
  end

  get "/stations/:id" do
    @station = Station.find(params[:id])
    erb :"stations/show"
  end

  get "/stations/:id/edit" do
    @station = Station.find(params[:id])
    erb :"stations/edit"
  end

  put "/stations/:id" do
    Station.update(name: params[:station][:name],
     city_id: City.find_or_create_by(params[:city]).id,
     dock_count_id: DockCount.find_or_create_by(params[:dock_count]).id,
     installation_date_id: InstallationDate.find_or_create_by(params[:installation_date]).id)

    @station = Station.find(params[:id])
     binding.pry

    redirect "/stations/#{@station.id}"
  end

  delete "/stations/:id" do
    @station = Station.destroy(params[:id])
    redirect "/stations"
  end

end
