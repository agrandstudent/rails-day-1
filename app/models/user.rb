class User < ActiveRecord::Base
  validates :email, :uniqueness => true, :presence => true

  has_many(
  :shortened_urls,
  :class_name => "ShortenedUrl",
  :primary_key => :id,
  :foreign_key => :submitter_id
  )

  has_many(
  :visits,
  :class_name => "Visit",
  :primary_key => :id,
  :foreign_key => :user_id
  )

  has_many(
   :visited_urls,
   :through => :visits,
   :source => :visited_url,
   :uniq => true  # -> { uniq } is alternate, preferred syntax
   )
end