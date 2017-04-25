json.extract! account, :id, :name, :email, :password, :professor, :institution_id, :created_at, :updated_at
json.url account_url(account, format: :json)
