require 'rails_helper'

RSpec.describe "Categories", type: :request do
    describe 'GET /index' do
        context 'quando há categorias cadastradas' do
            it 'retorna um lista de categorias' do
                category1 = Category.create(description: 'Categoria 01')
                category2 = Category.create(description: 'Categoria 02')

                get '/categories'

                puts response.body

                expect(response).to have_http_status(:ok)
                expect(response.body).to include (category1.to_json)
                expect(response.body).to include (category2.to_json)
            end

            it 'quando não há categorias cadastradas' do
                get '/categories'
                
                expect(JSON.parse(response.body)).to eq([])
            end
        end
    end

    describe "GET /show" do
        context 'quando a categoria existe' do 
            it 'retornar uma categoria específica' do
                category = Category.create(description: 'Alimentos')

                get "/categories/#{category.id}"

                expect(response).to have_http_status(:ok)
                expect(response.body).to eq(category.to_json)
            end

            # it 'quando não encontra a categoria' do 
            #     expect do
            #         get '/categories/99999' 
            #     end.to raise_error(ActiveRecord::RecordNotFound)
            # end
        end
    end

    describe 'Post /create' do
        context 'Com parâmetros válidos' do
            it 'Criar uma nova categoria' do
                post '/categories', params: { category: { description: 'Alimentos' } }

                expect(response).to have_http_status(:created)
            end
        end

        context 'Com parâmetros inválidos' do
            it 'Retorna erro de unprocessable entity' do
                post '/categories', params: { category: { description: nil } }

                expect(response).to have_http_status(:unprocessable_entity)
            end
        end
    end
end
