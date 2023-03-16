class ActivitiesController < ApplicationController
  def index
    @trip = Trip.find(params[:trip_id])
    @eat = @trip.activities.where(category: :eat, status: :pending)
    @explore = @trip.activities.where(category: :explore, status: :pending)
    @do = @trip.activities.where(category: :do, status: :pending)
    destination = @trip.destination
    @selected_activities = selected_activities
    @user = current_user
    eat_preference = @user.eat_preference_list
    do_preference = @user.do_preference_list
  end

    def selected_activities
      @trip = Trip.find(params[:trip_id])
      @selected_activities = @trip.activities.where(status: :added)
    end

    def added
      @trip = Trip.find(params[:trip_id])
      @activity = Activity.find(params[:id])
      @activity.added!
      redirect_to trip_activities_path(@trip)
    end

    def favourite
      @trip = Trip.find(params[:trip_id])
      @activity = Activity.find(params[:id])
      @activity.favourite!
      redirect_to trip_activities_path(@trip)
    end

  end
  #   client = OpenAI::Client.new
  #   eat_prompt = "Can you suggest 3 restaurants that are #{eat_preference} in #{destination}?
  #   Response must be in a JSON. JSON has an array with objects that has keys called name and description."
  #   do_prompt = "Can you suggest 3 activities that are #{do_preference} in #{destination}?
  #   Response must be in a JSON. JSON has an array with objects that has keys called name and description."
  #   explore_prompt = "Can you suggest 3 activities top in #{destination}? Response must be in a JSON. JSON has an array
  #   with objects that has keys called name and description."

  #   eat_response = client.completions(
  #     parameters: {
  #       model: 'text-davinci-003',
  #       prompt: eat_prompt,
  #       temperature: 0.3,
  #       max_tokens: 500
  #     }
  #   )

  #   do_response = client.completions(
  #     parameters: {
  #     model: 'text-davinci-003',
  #     prompt: do_prompt,
  #     max_tokens: 500
  #     }
  #   )

  #   explore_response = client.completions(
  #     parameters: {
  #     model: 'text-davinci-003',
  #     prompt: explore_prompt,
  #     max_tokens: 300
  #     }
  #   )

  #   eat_infos = JSON.parse(eat_response.dig('choices', 0, 'text'))
  #   eat_infos.map { |info| Activity.create(name: info['name'], description: info['description'], category: 0, trip: @trip) }

  #   do_infos = JSON.parse(do_response.dig('choices', 0, 'text'))
  #   do_infos.map { |info| Activity.create(name: info['name'], description: info['description'], category: 1, trip: @trip) }

  #   explore_infos = JSON.parse(explore_response.dig('choices', 0, 'text'))
  #   explore_infos.map { |info| Activity.create(name: info['name'], description: info['description'], category: 2, trip: @trip) }

  # end
