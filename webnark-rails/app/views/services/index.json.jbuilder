json.array!(@services) do |service|
  json.extract! service, :name, :description, :url, :slug, :hosting_provider, :country, :screenshot_url
  json.url service_url(service, format: :json)
end
