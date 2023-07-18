require 'rails_helper'

describe 'PUT /bookmarks' do
  let!(:bookmark) { Bookmark.create(url: 'http://igitangaza.com', title: 'Albums')}
  
  scenario 'valid bookmark attribute' do
    put "/bookmarks/#{bookmark.id}", params: {
      bookmark: {
        url: 'http://igitanga.com',
        title: 'Albums'
      }
    }

    expect(response.status).to eq(200)

    json = JSON.parse(response.body).deep_symbolize_keys
    expect(json[:url]).to eq('http://igitanga.com')
    expect(json[:title]).to eq('Albums')
  end

  scenario 'invalid bookmark attribute' do
    put "/bookmarks/#{bookmark.id}", params: {
      bookmark: {
        url: '',
        title: 'Albums',
      }
    }
    expect(response.status).to eq(422)

    json = JSON.parse(response.body).deep_symbolize_keys
    expect(json[:url]).to eq(["can't be blank"])

    expect(bookmark.reload.title).to eq('Albums')
    expect(bookmark.reload.url).to eq('http://igitangaza.com')
  end
end