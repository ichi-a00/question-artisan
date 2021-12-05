require 'base64'
require 'json'
require 'net/https'

module Language
  class << self
    def get_sentiment(text)
      # APIのURL作成 感情分析
      api_url = ENV['SENTIMENT']
      # APIリクエスト用のJSONパラメータ
      params = {
        document: {
          type: 'PLAIN_TEXT',
          content: text,
        },
      }.to_json
      # Google Cloud Natural Language APIにリクエスト
      uri = URI.parse(api_url)
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      request = Net::HTTP::Post.new(uri.request_uri)
      request['Content-Type'] = 'application/json'
      response = https.request(request, params)
      # APIレスポンス出力
      response_body = JSON.parse(response.body)
      if (error = response_body['error']).present?
        raise error['message']
      else
        # 感情
        response_body['documentSentiment']['score']
      end
    end

    def get_entity(text)
      # エンティティ分析
      api_url = ENV['ENTITY']
      # APIリクエスト用のJSONパラメータ
      params = {
        document: {
          type: 'PLAIN_TEXT',
          content: text,
        },
      }.to_json
      # Google Cloud Natural Language APIにリクエスト
      uri = URI.parse(api_url)
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      request = Net::HTTP::Post.new(uri.request_uri)
      request['Content-Type'] = 'application/json'
      response = https.request(request, params)
      # APIレスポンス出力
      response_body = JSON.parse(response.body)
      if (error = response_body['error']).present?
        raise error['message']
      else
        # binding.pry
        # エンティティで分けた名前だけを配列で返す。
        response_body['entities'].pluck('name')
      end
    end
  end
end
