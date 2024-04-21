require 'swagger_helper'

RSpec.describe 'api/authentication', type: :request do

  path '/api/signup' do

    post('signup authentication') do
      consumes 'application/json'
      produces 'application/json'
      description 'This endpoint is used to create ana authenticate a user'
      parameter name: :signup_user , in: :body, schema: { '$ref' => '#/components/schemas/signup_user' }

      response(201, 'successful') do
        schema '$ref' => '#/components/schemas/logged_in_user'
        let(:logged_in_user){ { token: 'jwt', user: { id: '1', email: 'user@example.com' } } }
        run_test!
      end

      response(422, 'unprocessible entity') do
        schema type: :object,
          properties: {
            email: { 
              type: :object,
              properties: {
               email:{
                type: :array, 
              }
            }
           }
          }
        let(:error){ {error: 'Invalid credentials' } }
        run_test!
      end
    end
  end

  path '/api/login' do

    post('login authentication') do
      consumes 'application/json'
      produces 'application/json'
      description 'This endpoint is used to log in a user'
      response(200, 'successful') do
        parameter name: :email , in: :body, schema: { '$ref' => '#/components/schemas/login_user' }
        run_test!
      end

      response(401, 'unauthorized') do
        schema type: :object,
          properties: {
            error: { 
              type: :string,
            }
          }
        let(:error){ {error: 'Invalid credentials' } }
        run_test!
      end
    end
  end
end
