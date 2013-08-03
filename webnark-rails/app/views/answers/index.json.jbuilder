json.array!(@answers) do |answer|
  json.extract! answer, :service_id, :report_choice_id, :notes
  json.url answer_url(answer, format: :json)
end
