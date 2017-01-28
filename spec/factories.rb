FactoryGirl.define do
  factory :user do
    provider 'provider'
    uid 'uid'
    name 'name'
    oauth_token 'oauth_token'
    oauth_secret 'oauth_secret'
  end

  factory :tweet do
    message 'foobar'
    url 'url'
    user
  end
end