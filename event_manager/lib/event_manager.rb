
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

# SWITCHING OVER TO USE THE CSV LIBRARY FROM RUBY
require "csv"
puts "EventManager Initialized!"

contents = CSV.open "event_attendees.csv"
contents.each do |row|
    name = row[2]
    puts name
end