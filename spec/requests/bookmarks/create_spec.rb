require 'rails_helper'

describe 'POST /bookmarks' do

  scenario 'valid bookmark attributes' do
    post '/bookmarks', params: {
      bookmark: {
        url: 'http://kbb.com',
        title: 'KBB'
      }
    }
    
    expect(response.status).to eq(201)
    json = JSON.parse(response.body).deep_symbolize_keys

    expect(json[:url]).to eq('http://kbb.com')
    expect(json[:title]).to eq('KBB')

    expect(Bookmark.count).to eq(1)
    expect(Bookmark.last.title).to eq('KBB')
  end

  scenario 'invalid bookmark attribute' do
    post '/bookmarks', params: {
      bookmark: {
        url: '',
        title: 'KBB',
      }
    }

    expect(response.status).to eq(422)

    json = JSON.parse(response.body).deep_symbolize_keys
    expect(json[:url]).to eq(["can't be blank"])

    expect(Bookmark.count).to eq(0)
  end
end
