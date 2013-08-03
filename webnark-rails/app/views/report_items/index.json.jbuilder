json.array!(@report_items) do |report_item|
  json.extract! report_item, :report_category_id, :name, :description, :help
  json.url report_item_url(report_item, format: :json)
end
