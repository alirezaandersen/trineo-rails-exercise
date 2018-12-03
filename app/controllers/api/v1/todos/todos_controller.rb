module Api
  module V1
    module Todos
      class TodosController < ApiController

        def completed
          render json: Todo.items_completed
        end

      end
    end
  end
end
