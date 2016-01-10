
class User < RedisModel
  attr_accessor :id, :email, :password_digest

  require 'bcrypt'
  include BCrypt
  before_create :assign_id
  before_create :hash_password
  validate :email_is_not_taken
  validate :email_is_valid
  validates :password, presence: true, on: :create


  def to_hash
    raw = {
      email: self.email,
      password_digest: password_digest
    }
  end

  def password
    @password ||= Password.new(password_digest)
  end

  def password=(new_password)
    @password = new_password
    self.password_digest = Password.create(@password)
  end

  def authenticate(given_password)
    password == given_password
  end

  protected

  def serialize
    return self.to_hash.to_json
  end

  def create
    run_callbacks :create do
      self.store
      true
    end
  end

  def store
    redis.multi do
      # Insert into redis:
      redis.set("distribot.#{table}.by.id:#{self.id}", self.serialize)
      # Save our email address-to-token:
      redis.set("distribot.#{table}.by.email:#{self.email}", self.id)
    end
  end

  private

  def hash_password
#    self.password_digest = @password
  end

  def assign_id
    self.id ||= SecureRandom.uuid
  end

  def email_is_valid
    if self.email.to_s.blank?
      self.errors.add :email, "can't be blank"
    end
    unless self.email.to_s =~ %r{^.+?@.+?\..+$}
      self.errors.add :email, 'invalid'
    end
  end

  def email_is_not_taken
    # Make sure that no user exists with the email address:
    other_user = User.find_by(email: self.email)
    if other_user && other_user.id != self.id
      self.errors.add :email, 'already taken'
    end
  end

end
