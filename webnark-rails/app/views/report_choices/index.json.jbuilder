json.array!(@report_choices) do |report_choice|
  json.extract! report_choice, :report_item_id, :name, :bonus, :points, :help
  json.url report_choice_url(report_choice, format: :json)
end
