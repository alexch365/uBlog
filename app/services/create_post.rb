# frozen_string_literal: true

require 'resolv'

class CreatePost
  include ActiveModel::Validations

  validate :check_post_attributes
  attr_reader :title, :body, :author_ip, :author_login, :post

  def self.execute(params)
    service = new(params)
    return service if service.invalid?

    service.create_author
    service.create
    service
  end

  def initialize(params)
    @post_attributes = params.slice(:title, :body, :author_ip)
    @author_login = params[:author_login]
  end

  def create_author
    author = User.find_or_create_by(login: @author_login)
    @post_attributes.merge!(user_id: author.id)
  end

  def create
    @post = Post.create(@post_attributes)
  end

  private

  def check_post_attributes
    errors.add(:title, :blank) if @post_attributes[:title].blank?
    errors.add(:body, :blank) if @post_attributes[:body].blank?
    errors.add(:author_login, :blank) if @author_login.blank?
    errors.add(:author_ip, :invalid) unless Resolv::IPv4::Regex.match?(@post_attributes[:author_ip].to_s)
  end
end
