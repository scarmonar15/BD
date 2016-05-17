json.array!(@counselings_students) do |counselings_student|
  json.extract! counselings_student, :id, :student_id, :counseling_id
  json.url counselings_student_url(counselings_student, format: :json)
end
