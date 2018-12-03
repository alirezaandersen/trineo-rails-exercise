require 'rails_helper'

RSpec.describe Api::V1::Todos::TodosController, type: :controller do

  describe 'Api TodosController' do

    context 'Get #completed' do
      let!(:todo_1) {create(:todo, title: 'Task 1')}
      let!(:todo_2) {create(:todo, title: 'Task 2')}
      let!(:todo_3) {create(:todo, title: 'Task 3')}

      it 'returns all Completed Todos with successful response ' do
        3.times {create(:item, todo: todo_1, completed: true)}
        3.times {create(:item, todo: todo_3, completed: true)}
        3.times {create(:item, todo: todo_2)}

        get :completed, format: :json
        expect(response).to be_success
        expect(response.code).to eq("200")
        expect(parsed_body.count).to eq(2)
        expect(parsed_body[0]['title']).to eq('Task 1')
        expect(parsed_body[1]['title']).to eq('Task 3')
      end
    end

    context 'Get #not_completed' do
      let!(:todo_1) {create(:todo, title: 'Task 1', completed: true)}
      let!(:todo_2) {create(:todo, title: 'Task 2')}

      it 'returns all Not Completed Todos with successful response' do
        3.times {create(:item, todo: todo_1, completed: true)}
        3.times {create(:item, todo: todo_2, completed: false)}

        get :not_completed, format: :json

        expect(response).to be_success
        expect(response.code).to eq("200")
        expect(parsed_body.count).to eq(1)
        expect(parsed_body[0]['title']).to eq('Task 2')
      end
    end
  end

  private
  def parsed_body
    @parsed_body ||= JSON.parse(response.body)
  end
end
