class ShortenedUrl < ActiveRecord::Base
  validates :short_url, :presence => true, :uniqueness => true
  validates :long_url, :submitter_id, :presence => true

  belongs_to(
  :submitter,
  :class_name => "User",
  :primary_key => :id,
  :foreign_key => :submitter_id
  )

  has_many(
  :visits,
  :class_name => "Visit",
  :primary_key => :id,
  :foreign_key => :shortened_url_id
  )

  has_many(
  :visitors,
  :through => :visits,
  :source => :visitor,
  :uniq => true
  )

  def self.random_code
    code = SecureRandom.urlsafe_base64(16)
    while self.all.include?(code)
      code = SecureRandom.urlsafe_base64(16)
    end
    code
  end

  def self.create_for_user_and_long_url!(user, long_url)
    options = { :submitter_id => user.id, :long_url => long_url,
                :short_url => self.random_code }

    short = ShortenedUrl.new(options)
    short.save!
    short
  end

  def num_clicks
    self.count(:visits)
  end

  def num_uniques
    self.distinct.count(:visits)
  end

  def num_recent_uniques
    self.visits.select{|visit| visit.created_at > Time.now - 600 }
  end
end