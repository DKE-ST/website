class Calendar::Event < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  belongs_to :brother, class_name: "User::Brother"
  #id  int(11)
  #title   varchar(255)
  validates :title, presence: true
  #desc  text
  validates :desc, presence: true
  #brother_id  int(11)
  validates :brother_id, presence: true
  #color   varchar(255)
  validates :color, presence: true
  #start   datetime
  validates :start, presence: true
  #end   datetime
  validates :end, presence: true
  validate :start_before_end
  #created_at  datetime
  #updated_at  datetime
  
  def self.get_events(params = {})
    events = []
    start_dt = (params.include? :start)?Date.parse(params[:start]):Date.today - 365
    end_dt = (params.include? :end)?Date.parse(params[:end]):Date.today + 365
    self.where("start >= ? and end <= ?", start_dt.to_datetime, end_dt.to_datetime).each do | event |
      events << {
        title: event.title,
        allDay: false,
        start: event.start,
        end: event.end,
        color: event.color,
        url: "#{event.events_path}/#{event.id}"
      }
    end
    return events
  end
  
 private
 
  def start_before_end
    unless self.end.nil? || self.start.nil?
      errors.add(:end, " must be after Start") if self.end <= self.start
    end
  end
  
end
