
# # READ ENTIRE FILE CONTENTS
# contents = File.read "event_attendees.csv"
# puts contents

# # READ FILE & OUTPUT LINE BY LINE
# lines = File.readlines "event_attendees.csv"
# lines.each do |line|
#     puts line
# end

# # DISPLAY FIRST NAME OF ALL ATTENDEES
# # 1ST - PUT EACH LINE INTO AN ARRAY (MAKES EACH COLUMN EASIER TO ACCESS BY INDEX)
# lines = File.readlines "event_attendees.csv"
# lines.each do |line|
#     columns = line.split(",")
#     p columns
# end

# # ACCESS FIRST_NAME AT INDEX [2]
# lines = File.readlines "event_attendees.csv"
# lines.each do |line|
#     columns = line.split(",")
#     name = columns[2]
#     puts name
# end

# # SKIP THE HEADER ROW
# # NOT THE BEST SOLUTION BECAUSE HEADER ROW NAMES COULD CHANGE LATER
# lines = File.readlines "event_attendees.csv"
# lines.each do |line|
#     next if line == " ,RegDate,first_Name,last_Name,Email_Address,HomePhone,Street,City,State,Zipcode\n"
#     columns = line.split(",")
#     name = columns[2]
#     puts name
# end

# # SKIP BY ROW INDEX
# lines = File.readlines "event_attendees.csv"
# row_index = 0
# lines.each do |line|
#     row_index = row_index + 1
#     next if row_index == 1
#     columns = line.split(",")
#     name = columns[2]
#     puts name
# end

# # LET'S SIMPLIFY THE ABOVE USING EACH_WITH_INDEX
# # SOLVES POSSIBLE CHANGES TO HEADER BUT IT ASSUMES THE HEADER ROW IS THE FIRST ROW
# lines = File.readlines "event_attendees.csv"
# lines.each_with_index do |line, index|
#     next if index == 0
#     columns = line.split(",")
#     name = columns[2]
#     puts name
# end

# # SWITCHING OVER TO USE THE CSV LIBRARY FROM RUBY

# contents = CSV.open "event_attendees.csv", headers: true
# contents.each do |row|
#     name = row[2]
#     puts name
# end

# # ACCESSING COLUMNS BY THEIR NAMES
# require "csv"
# puts "EventManager Initialized!"

# contents = CSV.open "event_attendees.csv", headers: true, header_converters: :symbol
# contents.each do |row|
#     name = row[:first_name]
#     puts name
# end

# # DISPLAYING ZIP CODES OF ALL ATTENDEES
# require "csv"
# puts "EventManager Initialized!"

# contents = CSV.open "event_attendees.csv", headers: true, header_converters: :symbol
# contents.each do |row|
#     name = row[:first_name]
#     zipcode = row[:zipcode]
#     puts "#{name} #{zipcode}"
# end

# # CLEANING UP OUR ZIP CODES
# # SOME ZIP CODES ARE REPRESENTED WITH LESS THAN FIVE DIGITS AND SOME ARE COMPLETELY MISSING
# require "csv"
# puts "EventManager Initialized!"

# contents = CSV.open "event_attendees.csv", headers: true, header_converters: :symbol
# contents.each do |row|
#     name = row[:first_name]
#     zipcode = row[:zipcode]
#     # if the zip code is less than 5 digits, add 0s to the front until it is 5 digits long
#     if zipcode.nil?
#         zipcode="00000"
#     elsif zipcode.length < 5
#         zipcode = zipcode.rjust 5, "0"
#         # if the zip code is more than 5 digits, truncate it to the first 5 digits
#     elsif zipcode.length > 5
#         zipcode = zipcode[0..4]
#     end
#     # if the zip code is 5 digits, assume it's correct
#     puts "#{name} #{zipcode}"
# end

# # MOVING CLEAN ZIP CODES TO A METHOD
# require "csv"
# # CLEAN ZIP CODE METHOD
# def clean_zipcode(zipcode)
#     if zipcode.nil?
#         "00000"
#     elsif zipcode.length<5
#         zipcode.rjust(5,"0")
#     elsif zipcode.length>5
#         zipcode[0..4]
#     else 
#         zipcode
#     end
# end

# puts "EventManager Initialized!"

# contents = CSV.open "event_attendees.csv", headers: true, header_converters: :symbol

# contents.each do |row|
#     name = row[:first_name]
#     zipcode = clean_zipcode(row[:zipcode])

#     puts "#{name} #{zipcode}"
# end

# # MOVING CLEAN ZIP CODES TO A METHOD
# require "csv"

# # REFACTOR CLEAN ZIP CODE METHOD
# def clean_zipcode(zipcode)
#   zipcode.to_s.rjust(5, "0")[0..4]
# end

# puts "EventManager Initialized!"

# contents = CSV.open "event_attendees.csv", headers: true, header_converters: :symbol

# contents.each do |row|
#     name = row[:first_name]
#     zipcode = clean_zipcode(row[:zipcode])

#     puts "#{name} #{zipcode}"
# end

# USE GOOGLE'S CIVIC INFORMATION

# # SHOWING ALL LEGISLATORS IN A ZIP CODE
# require "csv"
# require "google/apis/civicinfo_v2"

# civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
# civic_info.key = "AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw"

# def clean_zipcode(zipcode)
#   zipcode.to_s.rjust(5, "0")[0..4]
# end

# puts "EventManager Initialized!"

# contents = CSV.open "event_attendees.csv", headers: true, header_converters: :symbol

# contents.each do |row|
#     name = row[:first_name]
#     zipcode = clean_zipcode(row[:zipcode])

#     legislators = civic_info.representative_info_by_address(
#         address: zipcode,
#         levels: "country",
#         roles: ["legislatorUpperBody", "legislatorLowerBody"]
#   )
#   legislators = legislators.officials

#     puts "#{name} #{zipcode} #{legislators}"
# end

# # SHOWING ALL LEGISLATORS IN A ZIP CODE, WITH EXCEPTIONS FOR WRONG ZIP CODE
# require "csv"
# require "google/apis/civicinfo_v2"

# civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
# civic_info.key = "AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw"

# def clean_zipcode(zipcode)
#   zipcode.to_s.rjust(5, "0")[0..4]
# end

# puts "EventManager Initialized!"

# contents = CSV.open "event_attendees.csv", headers: true, header_converters: :symbol

# contents.each do |row|
#     name = row[:first_name]
#     zipcode = clean_zipcode(row[:zipcode])

#     begin
#     legislators = civic_info.representative_info_by_address(
#         address: zipcode,
#         levels: "country",
#         roles: ["legislatorUpperBody", "legislatorLowerBody"]
#   )
#   legislators = legislators.officials
# rescue
#     "You can find your legislators by visiting www.commoncause.org/take-action/find-elected-officials"
# end

#     puts "#{name} #{zipcode} #{legislators}"
# end

# # SHOWING ALL LEGISLATORS IN A ZIP CODE FIRST AND LAST NAMES ONLY, WITH EXCEPTIONS FOR WRONG ZIP CODE
# require "csv"
# require "google/apis/civicinfo_v2"

# civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
# civic_info.key = "AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw"

# def clean_zipcode(zipcode)
#   zipcode.to_s.rjust(5, "0")[0..4]
# end

# puts "EventManager Initialized!"

# contents = CSV.open "event_attendees.csv", headers: true, header_converters: :symbol

# contents.each do |row|
#     name = row[:first_name]
#     zipcode = clean_zipcode(row[:zipcode])

#     begin
#     legislators = civic_info.representative_info_by_address(
#         address: zipcode,
#         levels: "country",
#         roles: ["legislatorUpperBody", "legislatorLowerBody"]
#   )
#   legislators = legislators.officials

#   legislator_names = legislators.map(&:name)
  
#   legislators_string = legislator_names.join(", ")
# rescue
#     "You can find your legislators by visiting www.commoncause.org/take-action/find-elected-officials"
# end

#     puts "#{name} #{zipcode} #{legislators_string}"
# end

# # SHOWING ALL LEGISLATORS IN A ZIP CODE FIRST AND LAST NAMES ONLY, WITH EXCEPTIONS FOR WRONG ZIP CODE
# require "csv"
# require "google/apis/civicinfo_v2"

# def clean_zipcode(zipcode)
#     zipcode.to_s.rjust(5, "0")[0..4]
# end

# def legislators_by_zipcode(zip)
#     civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
#     civic_info.key = "AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw"

#     begin
#     legislators = civic_info.representative_info_by_address(
#         address: zip,
#         levels: "country",
#         roles: ["legislatorUpperBody", "legislatorLowerBody"])
#     legislators = legislators.officials
#     legislator_names = legislators.map(&:name)
#     legislator_names.join(", ")
#     rescue
#     "You can find your legislators by visiting www.commoncause.org/take-action/find-elected-officials"
#     end
# end

# puts "EventManager Initialized!"

# contents = CSV.open "event_attendees.csv", headers: true, header_converters: :symbol

# contents.each do |row|
#     name = row[:first_name]
#     zipcode = clean_zipcode(row[:zipcode])
#     legislators = legislators_by_zipcode(zipcode)

#     puts "#{name} #{zipcode} #{legislators}"
# end

# FORM LETTERS, FROM ATTENDEES TO REPRESENTATIVES

# # REPLACING WITH GSUB AND GSUB!
# # gsub - returns a new copy of the original string with the values replaced
# # gsub! - replaces the values in the original string

# require "csv"
# require "google/apis/civicinfo_v2"

# def clean_zipcode(zipcode)
#     zipcode.to_s.rjust(5, "0")[0..4]
# end

# def legislators_by_zipcode(zip)
#     civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
#     civic_info.key = "AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw"
    
#     begin
#         legislators = civic_info.representative_info_by_address(
#             address: zip,
#             levels: "country",
#             roles: ["legislatorUpperBody", "legislatorLowerBody"])
#             legislators = legislators.officials
#             legislator_names = legislators.map(&:name)
#             legislator_names.join(", ")
#         rescue
#             "You can find your legislators by visiting www.commoncause.org/take-action/find-elected-officials"
#         end
#     end
    
# puts "EventManager Initialized!"
    
# contents = CSV.open "event_attendees.csv", headers: true, header_converters: :symbol
    
# template_letter = File.read "form_letter.html"

# contents.each do |row|
#     name = row[:first_name]
#     zipcode = clean_zipcode(row[:zipcode])
#     legislators = legislators_by_zipcode(zipcode)

#     personal_letter= template_letter.gsub("FIRST_NAME",name)
#     personal_letter= template_letter.gsub!("LEGISLATORS",legislators)

#     puts personal_letter
# end

# # RUBY'S ERB - A TEMPLATE LANGUAGE

# require "csv"
# require "google/apis/civicinfo_v2"
# require "erb"

# def clean_zipcode(zipcode)
#     zipcode.to_s.rjust(5, "0")[0..4]
# end

# def legislators_by_zipcode(zip)
#     civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
#     civic_info.key = "AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw"
    
#     begin
#         legislators = civic_info.representative_info_by_address(
#             address: zip,
#             levels: "country",
#             roles: ["legislatorUpperBody", "legislatorLowerBody"]
#         ).officials
#         rescue
#             "You can find your legislators by visiting www.commoncause.org/take-action/find-elected-officials"
#         end
#     end
    
# puts "EventManager Initialized!"
    
# contents = CSV.open "event_attendees.csv", headers: true, header_converters: :symbol
    
# template_letter = File.read "form_letter.erb"
# erb_template = ERB.new template_letter

# contents.each do |row|
#     name = row[:first_name]
#     zipcode = clean_zipcode(row[:zipcode])
#     legislators = legislators_by_zipcode(zipcode)
#     form_letter = erb_template.result(binding)

#     puts form_letter
# end

# # OUTPUTTING FORM LETTERS TO A FILE

# require "csv"
# require "google/apis/civicinfo_v2"
# require "erb"

# def clean_zipcode(zipcode)
#     zipcode.to_s.rjust(5, "0")[0..4]
# end

# def legislators_by_zipcode(zip)
#     civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
#     civic_info.key = "AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw"
    
#     begin
#         legislators = civic_info.representative_info_by_address(
#             address: zip,
#             levels: "country",
#             roles: ["legislatorUpperBody", "legislatorLowerBody"]
#         ).officials
#         rescue
#             "You can find your legislators by visiting www.commoncause.org/take-action/find-elected-officials"
#         end
#     end
    
# puts "EventManager Initialized!"
    
# contents = CSV.open "event_attendees.csv", headers: true, header_converters: :symbol
    
# template_letter = File.read "form_letter.erb"
# erb_template = ERB.new template_letter

# contents.each do |row|
#     id = row[0]
#     name = row[:first_name]
#     zipcode = clean_zipcode(row[:zipcode])
#     legislators = legislators_by_zipcode(zipcode)
#     form_letter = erb_template.result(binding)

#    Dir.mkdir("output") unless Dir.exists? "output"

#    filename = "output/thanks_#{id}.html"

#    File.open(filename, "w") do |file|
#     file.puts form_letter
#    end
# end

# # MOVING FORM LETTER GENERATION TO A METHOD

# require "csv"
# require "google/apis/civicinfo_v2"
# require "erb"

# def clean_zipcode(zipcode)
#     zipcode.to_s.rjust(5, "0")[0..4]
# end

# def legislators_by_zipcode(zip)
#     civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
#     civic_info.key = "AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw"
    
#     begin
#         legislators = civic_info.representative_info_by_address(
#             address: zip,
#             levels: "country",
#             roles: ["legislatorUpperBody", "legislatorLowerBody"]
#         ).officials
#         rescue
#             "You can find your legislators by visiting www.commoncause.org/take-action/find-elected-officials"
#         end
#     end

# def save_thank_you_letter(id, form_letter)
#     Dir.mkdir("output") unless Dir.exists?("output")

#     filename = "output/thanks_#{id}.html"

#     File.open(filename, "w") do |file|
#         file.puts form_letter
#     end
# end
    
# puts "EventManager Initialized!"
    
# contents = CSV.open "event_attendees.csv", headers: true, header_converters: :symbol
    
# template_letter = File.read "form_letter.erb"
# erb_template = ERB.new template_letter

# contents.each do |row|
#     id = row[0]
#     name = row[:first_name]
#     zipcode = clean_zipcode(row[:zipcode])
#     legislators = legislators_by_zipcode(zipcode)
#     form_letter = erb_template.result(binding)
#     save_thank_you_letter(id,form_letter)
# end

# CLEAN UP PHONE NUMBERS

require "csv"
require "google/apis/civicinfo_v2"
require "erb"

def clean_zipcode(zipcode)
    zipcode.to_s.rjust(5, "0")[0..4]
end

def clean_phone_numbers(phone_number)
    phone_number.to_s
    phone_number.sub("^0-9", "" )
    puts phone_number
end

def legislators_by_zipcode(zip)
    civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
    civic_info.key = "AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw"
    
    begin
        legislators = civic_info.representative_info_by_address(
            address: zip,
            levels: "country",
            roles: ["legislatorUpperBody", "legislatorLowerBody"]
        ).officials
        rescue
            "You can find your legislators by visiting www.commoncause.org/take-action/find-elected-officials"
        end
    end

def save_thank_you_letter(id, form_letter)
    Dir.mkdir("output") unless Dir.exists?("output")

    filename = "output/thanks_#{id}.html"

    File.open(filename, "w") do |file|
        file.puts form_letter
    end
end
    
puts "EventManager Initialized!"
    
contents = CSV.open "event_attendees.csv", headers: true, header_converters: :symbol
    
template_letter = File.read "form_letter.erb"
erb_template = ERB.new template_letter

contents.each do |row|
    id = row[0]
    name = row[:first_name]
    zipcode = clean_zipcode(row[:zipcode])
    phone = clean_phone_numbers(row[:homephone])
    legislators = legislators_by_zipcode(zipcode)
    form_letter = erb_template.result(binding)
    save_thank_you_letter(id,form_letter)
end