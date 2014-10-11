json.array!(@projects) do |project|
  json.extract! project, :content, :user_id
  json.url project_url(project, format: :json)
end