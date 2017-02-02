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
    @stations = Station.all
    erb :"stations/dashboard"
  end

  get "/trips" do
    @trips = Trip.all.order(start_date: :desc)
    @trips = @trips.paginate(page: params[:page], per_page: 30)
    erb :"trips/index"
  end

  get "/trips/new" do
    @stations = Station.all
    erb :"trips/new"
  end

  post "/trips" do
    params["trip"] = Trip.format_parameters(params[:trip])
    @trip = Trip.create(params[:trip])

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
    Trip.update(params[:id].to_i, params[:trip])

    redirect "/trips/#{params[:id].to_i}"
  end

  delete "/trips/:id" do
    @trip = Trip.destroy(params[:id])
    redirect "/trips"
  end

  get "/trips-dashboard" do
   @trips = Trip.all
   erb :"trips/dashboard"
 end

  get "/conditions" do
    @conditions = Condition.all
    erb :"conditions/index"
  end

  get "/conditions/new" do
    erb :"conditions/new"
  end

  post "/conditions" do
    params[:condition] = Condition.format_parameters(params[:condition])
    @condition = Condition.create(params[:condition])
    @condition.remove_id_from_trips unless @condition.date_same?(params[:condition][:date])

    redirect "/conditions/#{@condition.id}"
  end

  get "/conditions/:id" do
    @condition = Condition.find(params[:id])
    erb :"conditions/show"
  end

  get "/conditions/:id/edit" do
    @condition = Condition.find(params[:id])
    erb :"conditions/edit"
  end

  put "/conditions/:id" do
    @condition = Condition.find(params[:id])
    @condition.remove_id_from_trips unless @condition.date_same?(params[:condition][:date])

    Condition.update(params[:id].to_i, params[:condition])

    redirect "/conditions/#{@condition.id}"
  end

  delete "/conditions/:id" do
    @condition = Condition.destroy(params[:id])
    @condition.remove_id_from_trips
    redirect "/conditions"
  end

  get "/condition-dashboard" do
    @conditions = Condition.all
    erb :"conditions/dashboard"
  end

end
