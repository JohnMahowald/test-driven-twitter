FactoryGirl.define do
  factory :user do
    email "john@example.com"
    username "@johnwritescode"
    password "example"
  end

  factory :short_user_password, class: User do
    to_create { |instance| instance.save(validate: false) }
    email "john@example.com"
    username "@johnwritescode"
    password "short"
  end
end