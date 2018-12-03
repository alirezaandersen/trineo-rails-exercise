require 'rails_helper'

RSpec.describe Todo, type: :model do

  it { should have_many(:items).dependent(:destroy) }
  it { should validate_presence_of(:title) }

  describe 'items_completed' do

    context 'returns only fully completed task' do
      let(:todo_1) {create(:todo, title: 'Task 1') }
      let!(:item_1) {create(:item, todo: todo_1, title: 'Item 1', completed: true)}
      let!(:item_2) {create(:item, todo: todo_1, title: 'Item 2')}

      let(:todo_2) {create(:todo, title: 'Task 2') }
      let!(:item_1) {create(:item, todo: todo_2, title: 'Item 1', completed: true)}
      let!(:item_2) {create(:item, todo: todo_2, title: 'Item 2', completed: true)}
      it'returns only Task 2 ' do
        completed_todo_array = Todo.items_completed
        expect(completed_todo_array.count).to eq(1)
        expect(completed_todo_array.first.title).to eq('Task 2')
      end
    end

    context 'will not return task if task has no items' do
      let!(:todo_3) {create(:todo, title: 'Task 3') }
      it 'should return 0 task' do
        completed_todo_array = Todo.items_completed
        expect(completed_todo_array.count).to eq(0)
        completed_todo_array.empty?
      end
    end

    context 'will not return a task if only partial items completed' do
      let(:todo_1) {create(:todo, title: 'Task 1') }
      let!(:item_1) {create(:item, todo: todo_1, title: 'Item 1', completed: true)}
      let!(:item_2) {create(:item, todo: todo_1, title: 'Item 2')}

      it 'should return 0 task' do
        completed_todo_array = Todo.items_completed
        expect(completed_todo_array.count).to eq(0)
        completed_todo_array.empty?
      end
    end
  end
end
