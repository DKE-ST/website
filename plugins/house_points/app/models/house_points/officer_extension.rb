Chapter::Officer.class_eval do
  has_many :point_entries, class_name: "HousePoints::Entry"
end