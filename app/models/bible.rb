class Bible
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  
  attr_accessor :class_num, :year, :semester, :uname
  
  validates :class_num, presence: true
  validates :year, presence: true , format: {with: /[\d]+/} , length: {minimum: 4, maximum: 4}
  validates :semester, presence: true , format: {with: /Fall|IAP|Spring/}
  
  def initialize(attributes = {})
    if attributes.class == ActionController::Parameters || attributes.class == Hash
      attributes.each do |name, value|
        send("#{name}=", value)
      end
    end
  end
  
  ###### Creates a new Bible ######
  
  def create(new_bible)
    if new_bible[:material].nil?
      self.errors[:base] << "No file was uploaded"
      return false
    elsif new_bible[:material].content_type != "application/zip"
      self.errors[:base] << "Incorrect File Type"
      return false
    else
      
      Dir.chdir(Bible.tmp_loc)
      `mkdir #{self.uname}` unless File.directory?(self.uname)
      Dir.chdir(self.uname)
      
      uploaded_io=new_bible[:material]
      File.open("#{self.class_num}.zip", "wb") do |file|
        file.write(uploaded_io.read)
      end
      
      `rm -rf #{self.class_num}` if File.directory?(self.class_num)
      `mkdir #{self.class_num}`
      `unzip #{self.class_num}.zip -d #{self.class_num}/"#{self.semester} #{self.year}"`
      `rm #{self.class_num}.zip`
      rm_redundant_dir("#{self.class_num}/#{self.semester} #{self.year}")
      Dir.chdir(Rails.root.to_s)
      return true
    end
  end
  
  ###### Used to recursively remove unneeded top level directories ######
  def rm_redundant_dir(dir_name)
    entries = Dir.entries(dir_name)
    entries.delete(".")
    entries.delete("..")
    print dir_name
    print entries
    if entries.length == 1 && File.directory?("#{dir_name}/#{entries[0]}")
      Dir.foreach("#{dir_name}/#{entries[0]}") do | file |
        unless file =~ /\A([.]{1,2})\z/
          `mv "#{dir_name}/#{entries[0]}/#{file}" "#{dir_name}"`
        end
      end
      Dir.rmdir("#{dir_name}/#{entries[0]}")
      rm_redundant_dir(dir_name)
    end
  end
  
  
  ######Prints file structure tree for a bible ######
  def self.print_structure(dir_name, spacer = "-- ")
    out = ""
    Dir.foreach(dir_name) do | file |
      unless file =~ /\A[.].*\z/
        out += "#{spacer}#{file}<br>"
        puts "#{spacer}#{file}"
        if File.directory?("#{dir_name}/#{file}")
          out += Bible.print_structure("#{dir_name}/#{file}", spacer + "-- ")
        end
      end
    end
    return out
  end
  
 private
 
  def self.tmp_loc
    return Rails.root.join("db/bibles").to_s
  end
  
end
