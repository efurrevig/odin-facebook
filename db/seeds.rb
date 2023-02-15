
# Sample users

user_names = ["John Smith", "Jane Doe", "Bob Jones", "Sally Smith", "Joe Bloggs"]
user_emails = ["test1@test.com", "test2@test.com", "test3@test.com", "test4@test.com", "test5@test.com"]

user_names.each_with_index do |name, index|
  user = User.new
  user.email = user_emails[index]
  user.password = "password"
  user.name = name
  user.save!
end