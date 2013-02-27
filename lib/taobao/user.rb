class Taobao::User
  attr_reader :nick
  # Retrive user info by nickname
  # @param nickname [String]
  def initialize(nickname)
    @nick = nickname
  end

  # @return [Integer]
  def good_purchases_count
    cached_response[:buyer_credit][:good_num].to_i
  end

  # @return [Integer]
  def buyer_level
    cached_response[:buyer_credit][:level].to_i
  end

  # @return [Integer]
  def buyer_score
    cached_response[:buyer_credit][:score].to_i
  end

  # @return [Integer]
  def total_purchases_count
    cached_response[:buyer_credit][:total_num].to_i
  end

  # @return [Integer]
  def good_sales_count
    cached_response[:seller_credit][:good_num].to_i
  end

  # @return [Integer]
  def seller_level
    cached_response[:seller_credit][:level].to_i
  end

  # @return [Integer]
  def seller_score
    cached_response[:seller_credit][:score].to_i
  end

  # @return [Integer]
  def total_sales_count
    cached_response[:seller_credit][:total_num].to_i
  end

  # @return [DateTime]
  def registration_date
    DateTime.parse cached_response[:created]
  end

  # @return [DateTime]
  def last_visit
    DateTime.parse cached_response[:last_visit]
  end

  # @return [String]
  def city
    cached_response[:location][:city]
  end

  # @return [String]
  def state
    cached_response[:location][:state]
  end

  # @return [Symbol]
  def sex
    return :unknown unless cached_response.has_key? :sex
    cached_response[:sex] == 'm' ? :male : :female
  end

  # @return [String]
  def type
    cached_response[:type]
  end

  # @return [String]
  def uid
    cached_response[:uid]
  end

  # @return [Integer]
  def id
    cached_response[:user_id].to_i
  end

  private
  def cached_response
    @response ||= retrieve_response[:user_get_response][:user]
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