module Calendar
  class EventsController < ApplicationController
    
    def new
      @event = Calendar::Event.new
    end
    
    def create
      @event = Calendar::Event.new(event_params(params))
      if @event.valid?
        @event.save
        redirect_to calendar_path
      else
        render "new"
      end
    end
    
    def calendar
    end
    
    def mit_events
      @mit_events = Calendar::Mit.get_registrar_events(event_filter_params(params))
      render json: @mit_events
    end
    
    def index
      @dke_events = Calendar::Event.get_events(event_filter_params(params))
      render json: @dke_events
    end
    
    def show
      @event = Calendar::Event.find(params[:id])
    end
    
    def edit
      @event = Calendar::Event.find(params[:id])
    end
    
    def update
      @event = Calendar::Event.find(params[:id])
      if @event.update_attributes(event_params(params))
        redirect_to calendar_path
      else
        render "edit"
      end
    end
    
    def destroy
      @event = Calendar::Event.find(params[:id])
      @event.destroy
      redirect_to calendar_path
    end
    
   private
   
    def event_params(params)
      return params.require(:event).permit(:title, :start, :end, :desc)
    end
   
    def event_filter_params(params)
      return params.permit(:start, :end)
    end
    
  end
end
