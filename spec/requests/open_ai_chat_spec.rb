require 'swagger_helper'

RSpec.describe 'open_ai_chat', type: :request do

  path '/chat' do

    post('create open_ai_chat') do
      consumes 'application/json'
      produces 'application/json'
      description 'This endpoint is used to chat with chatGPT'
      parameter name: :message , in: :body, schema: { '$ref' => '#/components/schemas/request_message' }
      parameter name: :Authorization, in: :header, type: :string
      response(201, 'successful') do
        let(:'Accept') { 'application/json' } 
        run_test!
      end
    end
  end
end
