require 'date'

class Taobao::User

  def initialize(nickname)
    @nick = nickname
  end

  def good_purchases_count
    cached_response[:buyer_credit][:good_num].to_i
  end

  def buyer_level
    cached_response[:buyer_credit][:level].to_i
  end

  def buyer_score
    cached_response[:buyer_credit][:score].to_i
  end

  def total_purchases_count
    cached_response[:buyer_credit][:total_num].to_i
  end

  def good_sales_count
    cached_response[:seller_credit][:good_num].to_i
  end

  def seller_level
    cached_response[:seller_credit][:level].to_i
  end

  def seller_score
    cached_response[:seller_credit][:score].to_i
  end

  def total_sales_count
    cached_response[:seller_credit][:total_num].to_i
  end

  def registration_date
    DateTime.parse cached_response[:created]
  end

  def last_visit
    DateTime.parse cached_response[:last_visit]
  end

  def city
    cached_response[:location][:city]
  end

  def state
    cached_response[:location][:state]
  end

  def sex
    if cached_response.has_key? :sex
      return :male if cached_response[:sex] == 'm'
      return :female if cached_response[:sex] == 'f'
    end
    :unknown
  end

  def type
    cached_response[:type]
  end

  def uid
    cached_response[:uid]
  end

  def id
    cached_response[:user_id].to_i
  end

  private
  def cached_response
    @response ||= retrieve_response[:user_get_response][:user]
    @response
  end

  def retrieve_response
    fields = [:user_id, :uid, :nick, :sex, :buyer_credit, :seller_credit,
      :location, :created, :last_visit, :birthday, :type, :status, :alipay_no,
      :alipay_account, :alipay_account, :email, :consumer_protection,
      :alipay_bind].join ','
    params = {method: 'taobao.user.get', fields: fields, nick: @nick}
    Taobao.api_request params
  end

end