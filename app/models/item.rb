class Item < ApplicationRecord
  belongs_to :todo
  validates_presence_of :title

  def task_status
    td = self.todo_id
    if self.completed == true && Item.where(todo_id: td, completed: true).count == Item.where(todo_id: td).count
      Todo.find(td).update!(completed: true)
    else
      Todo.find(td).update!(completed:false)
    end
    self
  end
  
end
