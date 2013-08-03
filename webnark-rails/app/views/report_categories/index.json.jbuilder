json.array!(@report_categories) do |report_category|
  json.extract! report_category, :name, :description, :icon_url
  json.url report_category_url(report_category, format: :json)
end
