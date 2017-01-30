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
    erb :"stations/new"
  end

  post "/stations" do
    @station = Station.create(name: params[:station][:name],
     city_id: City.find_or_create_by(params[:city]).id,
     dock_count: params[:station][:dock_count],
     installation_date: params[:station][:installation_date])
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
     dock_count: params[:station][:dock_count],
     installation_date: params[:station][:installation_date])

    @station = Station.find(params[:id])

    redirect "/stations/#{@station.id}"
  end

  delete "/stations/:id" do
    @station = Station.destroy(params[:id])
    redirect "/stations"
  end

  get "/station-dashboard" do
    @stations = Station
    @dock_min = Station.minimum(:dock_count)
    @dock_max = Station.maximum(:dock_count)
    erb :"stations/dashboard"
  end

  get "/trips" do
    @trips = Trip.all
    erb :"trips/index"
  end

  get "/trips/new" do
    @stations = Station.all
    erb :"trips/new"
  end

  post "/trips" do
    @trip = Trip.create(params[:trip])
    redirect "/trips/#{@trip.id}"
  end

  get "/trips/:id" do
    @trip = Trip.find(params[:id])
    erb :"trips/show"
  end

  get "/trips/:id/edit" do
    @trip = Trip.find(params[:id])
    erb :"trips/edit"
  end

  put "/trips/:id" do
    Trip.update(params[:trip])

    @trip = Trip.find(params[:id])

    redirect "/trips/#{@trip.id}"
  end

  delete "/trips/:id" do
    @trip = Trip.destroy(params[:id])
    redirect "/trips"
  end
end
