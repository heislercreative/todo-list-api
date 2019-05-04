class TaskSerializer < ActiveModel::Serializer
  attributes :id, :text, :completed, :project_id
end
