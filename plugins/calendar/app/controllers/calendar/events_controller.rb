module Calendar
  class EventsController < ApplicationController
    
    def calendar
    end
    
    def mit_events
      @mit_events = Calendar::Mit.get_registrar_events
      render json: @mit_events
    end
    
    def index
      
    end
    
  end
end
