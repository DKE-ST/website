class Bible
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  
  attr_accessor :class_num, :year, :semester, :uname
  
  validates :class_num, presence: true , format: {with: /\A\w+(.\w+)?\z/}
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
    puts new_bible[:material].content_type !=~ /\Aapplication\/(zip|octet-stream)\z/
    puts new_bible[:material].content_type
    if new_bible[:material].nil?
      self.errors[:base] << "No file was uploaded"
      return false
    elsif !(new_bible[:material].content_type =~ /(zip|octet-stream)/)
      self.errors[:base] << "Incorrect File Type.  Please upload a .zip file"
      return false
    else
      
      Dir.chdir(Bible.tmp_loc)
      `mkdir "#{self.class_num}"` unless File.directory?(self.class_num)
      Dir.chdir(self.class_num)
      
      uploaded_io=new_bible[:material]
      File.open("#{self.class_num}.zip", "wb") do |file|
        file.write(uploaded_io.read)
      end
      
      dir_name = "#{self.semester} #{self.year}_#{self.uname}"
      `rm -rf "#{dir_name}"` if File.directory?(dir_name)
      `mkdir "#{dir_name}"`
      `unzip "#{self.class_num}.zip" -d "#{dir_name}"`
      `rm "#{self.class_num}.zip"`
      rm_redundant_dir(dir_name)
      Dir.chdir(Rails.root.to_s)
      return true
    end
  end
  
  ###### Used to recursively remove unneeded top level directories ######
  def rm_redundant_dir(dir_name)
    entries = Dir.entries(dir_name)
    entries.delete(".")
    entries.delete("..")
    `rm -rf "#{dir_name}/__MACOSX"` if entries.delete("__MACOSX")
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
  
  ######Prints out a list of bibles waiting to be confiremd ######
  def self.get_new_bibles
    out = []
    Dir.entries(Bible.tmp_loc).reject{|entry| entry =~ /\A([.]{1,2})\z/}.each do | user |
      Dir.entries("#{Bible.tmp_loc}/#{user}").reject{|entry| entry =~ /\A([.]{1,2})\z/}.each do | class_num |
        Dir.entries("#{Bible.tmp_loc}/#{user}/#{class_num}").reject{|entry| entry =~ /\A([.]{1,2})\z/}.each do | semester |
          link = "#{class_num}-#{semester}-#{user}".gsub(".","_")
          out << [class_num,semester,user,link]
        end
      end
    end
    return out
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
    return "/lambda/samba_share/Bibles/Added Recently" if Settings.mode?(0)
    return Rails.root.join("db/bibles").to_s
  end
  
end
