class TaskSerializer < ActiveModel::Serializer
  attributes :id, :text, :completion
end
