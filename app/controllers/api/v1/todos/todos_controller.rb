module Api
  module V1
    module Todos
      class TodosController < ApiController

        def completed
          render json: Todo.items_completed
        end

        def not_completed
          render json: Todo.where(completed: false)
        end

      end
    end
  end
end
