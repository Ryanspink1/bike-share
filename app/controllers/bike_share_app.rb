require 'pry'
require 'will_paginate'
require 'will_paginate/active_record'

class BikeShareApp < Sinatra::Base
  include WillPaginate::Sinatra::Helpers

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
    @station = Station.create(
      name:              params[:station][:name],
      city_id:           City.find_or_create_by(params[:city]).id,
      dock_count:        params[:station][:dock_count],
      installation_date: params[:station][:installation_date]
    )
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
    Station.update(params[:id].to_i,
      name:              params[:station][:name],
      city_id:           City.find_or_create_by(params[:city]).id,
      dock_count:        params[:station][:dock_count],
      installation_date: params[:station][:installation_date]
    )

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
    @trips = Trip.all.order(start_date: :desc)
    @trips = @trips.paginate(page: params[:page], per_page: 30)
    erb :"trips/index"
  end

  get "/trips/new" do
    erb :"trips/new"
  end

  post "/trips" do
    params["trip"] = Trip.format_parameters(params[:trip])
    @trip = Trip.create(
      duration:          params[:trip][:duration],
      start_date:        params[:trip][:start_date],
      start_station_id:  params[:trip][:start_station_id],
      end_date:          params[:trip][:end_date],
      end_station_id:    params[:trip][:end_station_id],
      bike_id:           params[:trip][:bike_id],
      subscription_type: params[:trip][:subscription_type],
      zip_code:          params[:trip][:zip_code]
    )
    
    redirect "/trips/#{@trip.id}"
  end

  get "/trips/:id" do
    @trip = Trip.find(params[:id])
    erb :"trips/show"
  end

  get "/trips/:id/edit" do
    @trip = Trip.find(params[:id])
    @stations = Station.all
    @subscription_type_list = Trip.subscription_type_list
    erb :"trips/edit"
  end

  put "/trips/:id" do
    params["trip"] = Trip.format_parameters(params[:trip])
    Trip.update(params[:id].to_i,
      duration:          params[:trip][:duration],
      start_date:        params[:trip][:start_date],
      start_station_id:  params[:trip][:start_station_id],
      end_date:          params[:trip][:end_date],
      end_station_id:    params[:trip][:end_station_id],
      bike_id:           params[:trip][:bike_id],
      subscription_type: params[:trip][:subscription_type],
      zip_code:          params[:trip][:zip_code]
    )

    redirect "/trips/#{@trip.id}"
  end

  delete "/trips/:id" do
    @trip = Trip.destroy(params[:id])
    redirect "/trips"
  end

end
