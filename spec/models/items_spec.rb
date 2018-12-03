require 'rails_helper'

RSpec.describe Item, type: :model do

  it { should belong_to(:todo) }
  it { should validate_presence_of(:title) }

  describe 'task_status' do
    let!(:todo_1) {create(:todo, title: 'Task 1') }
    let!(:item_1) {create(:item, todo: todo_1, title: 'Item 1')}

    it 'will update the status of a Todo list based on if Item is complete' do
      item_1.task_status
      expect(todo_1.completed).to be_falsey
      item_1.update!(completed: true)
      item_1.task_status
      todo_updated = Todo.find(item_1.todo_id)
      expect(todo_updated.completed).to be_truthy
    end

    it 'will update the status of a Todo list based on if Item is not complete' do
      item_1.update!(completed: true)
      item_1.task_status
      todo_updated = Todo.find(item_1.todo_id)
      expect(todo_updated.completed).to be_truthy

      item_1.update!(completed: false)
      item_1.task_status
      todo_updated = Todo.find(item_1.todo_id)
      expect(todo_updated.completed).to be_falsey
    end
  end
end
