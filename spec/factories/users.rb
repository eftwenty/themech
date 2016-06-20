FactoryGirl.define do
  factory :user do
    email 'some@mail.mail'
    password 'pewpew'
    password_confirmation 'pewpew'
    first_name 'Dick'
    last_name 'Johnson'
  end
end