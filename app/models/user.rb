#require "digest/sha2"

class User < ActiveRecord::Base

  attr_protected :id

  belongs_to :ville
  validates_presence_of :username
  validates_uniqueness_of :username


  # TODO : scope mairie_id

  #def password=(pass)
  #  salt = [Array.new(6){rand(256).chr}.join].pack("m").chomp
  #  'self.password_salt, self.password_hash = salt, Digest::SHA256.hexdigest(pass + salt)
  #  self.password_hash =pass
  #end

  def self.authenticate(username, password)
    user = User.find_by_username(username)
    if user.blank? || password  != user.password_hash
       return nil
    else
       return user
    end
  end

end
