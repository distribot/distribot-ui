
class RedisModel

  include ActiveModel::Validations
  include ActiveModel::Callbacks
  define_model_callbacks :create, :update

  def initialize(attributes = {})
    @attributes = attributes
    attributes.each do |key,val|
      send "#{key}=", val
    end
  end

  def read_attribute_for_validation(key)
    @attributes[key]
  end

  def self.first
    all.first
  end

  def save!
    false unless self.save
  end

  def save(*args)
    unless self.valid?
      return false
    end

    if self.id
      run_callbacks :update do
        self.update
      end
    else
      run_callbacks :create do
        self.create
      end
    end
  end

  def update
    raise NotImplementedError.new
  end

  def self.find(id)
    find_by_id(id)
  end

  def self.find_by_id(id)
    raw_json = redis.get("distribot.#{table}.by.id:#{id}")
    if raw_json
      self.new JSON.parse(raw_json).merge(id: id)
    else
      return nil
    end
  end

  def self.find_by_email(email)
    if id = redis.get("distribot.#{table}.by.email:#{email}")
      return self.find_by_id(id)
    else
      return nil
    end
  end

  def self.find_by(args={})
    send("find_by_#{args.keys.first}", args.values.first)
  end

  def delete
    # Delete the email->id and the id->data values:
    redis.multi do
      redis.del("distribot.#{table}.by.id:#{self.id}")
      redis.del("distribot.#{table}.by.email:#{self.email}")
    end
  end

  def self.all
    redis.scan_each(match: "distribot.#{table}.by.id:*").map do |key|
      id = key.gsub(/^distribot\.#{table}\.by\.id\:/,'')
      find_by_id(id)
    end
  end

  def self.table
    self.class.to_s.downcase.pluralize
  end

  def table
    self.class.table
  end

  def self.delete_all
    self.all.map(&:delete)
  end

  protected

  def self.redis
    Distribot.redis
  end

  def redis
    self.class.redis
  end

end
