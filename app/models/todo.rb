class Todo < ApplicationRecord
  has_many :items, dependent: :destroy
  validates_presence_of :title

  def self.items_completed
    total_task = self.ids
    total_task.each do |td|
      if !Item.where(todo_id: td).empty? && Item.where(todo_id: td,completed:true).count == Item.where(todo_id: td).count
        self.find(td).update(completed: true)
      end
    end
    self.where(completed:true)
  end

end
