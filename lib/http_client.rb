require 'hashkey'

class HttpClient
  HTTP_HOST = "http://api.sponsorpay.com"
  API_KEY = "b07a12df7d52e6c118e5d47d3f9e60135b109a1f"

  attr_reader :conn

  def initialize(uid:, pub0:, page:)
    @conn = Faraday.new(url: HTTP_HOST)
    @uid = uid
    @pub0 = pub0
    @page = page || 1
  end

  def fetch_offers
    response = conn.get('feed/v1/offers.json', final_params)
    JSON.parse(response.body)
  end

  def params
    @params ||= default_params.merge({ uid: @uid, pub0: @pub0, page: @page })
  end

  def hashkey
    @hashkey ||= Hashkey.new(params).generate
  end

  def final_params
    params.merge({ hashkey: hashkey })
  end

  private

  def default_params
    {
      appid: "157",
      format: "json",
      device_id: "2b6f0cc904d137be2e1730235f5664094b83",
      locale: "de",
      ip: "109.235.143.113",
      offer_types: "112",
      timestamp: Time.now.to_i
    }
  end

end
