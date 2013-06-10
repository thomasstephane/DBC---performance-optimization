class User < ActiveRecord::Base
  has_many :karma_points

  attr_accessible :first_name, :last_name, :email, :username, :score

  validates :first_name, :presence => true
  validates :last_name, :presence => true

  validates :username,
            :presence => true,
            :length => {:minimum => 2, :maximum => 32},
            :format => {:with => /^\w+$/},
            :uniqueness => {:case_sensitive => false}

  validates :email,
            :presence => true,
            :format => {:with => /^[\w+\-.]+@[a-z\d\-.]+\.[a-z]+$/i},
            :uniqueness => {:case_sensitive => false}

  def self.by_karma
    order('score DESC')
  end

  def self.page(int)
    User.by_karma.limit(50).offset((int-1) * 50)
  end

  # def self.old_by_karma
  #   joins(:karma_points).group('users.id').order('SUM(karma_points.value) DESC')
  # end

  def total_karma
    self.score
  end

  def score_points
    self.karma_points.sum(:value)
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
