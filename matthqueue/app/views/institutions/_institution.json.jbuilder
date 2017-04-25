json.extract! institution, :id, :name, :password, :secret, :email_regex, :created_at, :updated_at
json.url institution_url(institution, format: :json)
