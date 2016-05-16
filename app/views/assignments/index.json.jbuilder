json.array!(@assignments) do |assignment|
  json.extract! assignment, :id, :limit_date, :description, :grade
  json.url assignment_url(assignment, format: :json)
end
