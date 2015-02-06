# -*- encoding: utf-8 -*-

class Asciicast < ActiveRecord::Base
  include ActiveUUID::UUID
  belongs_to :user

  has_many :comments, -> { order(:created_at) }, dependent: :destroy
  has_many :likes, dependent: :destroy

  ORDER_MODES = { recency: 'created_at', popularity: 'views_count' }

  scope :featured, -> { where(featured: true) }
  scope :by_recency, -> { order("created_at DESC") }
  scope :by_random, -> { order("RAND()") }
  scope :latest_limited, -> (n) { by_recency.limit(n).includes(:user) }
  scope :random_featured_limited, -> (n) {
    featured.by_random.limit(n).includes(:user)
  }

  mount_uploader :stdin_data,    StdinDataUploader
  mount_uploader :stdin_timing,  StdinTimingUploader
  mount_uploader :stdout_data,   StdoutDataUploader
  mount_uploader :stdout_timing, StdoutTimingUploader
  mount_uploader :stdout_frames, StdoutFramesUploader

  serialize :snapshot, ActiveSupportJsonProxy

  validates :stdout_data, :stdout_timing, presence: true
  validates :terminal_columns, :terminal_lines, :duration, presence: true
  validates :snapshot_at, numericality: { greater_than: 0, allow_blank: true }

  class << self
    def cache_key
      timestamps = scoped.select(:updated_at).map { |o| o.updated_at.to_i }
      Digest::MD5.hexdigest timestamps.join('/')
    end

    def paginate(page, per_page)
      page(page).per(per_page)
    end

    def for_category_ordered(category, order, page = nil, per_page = nil)
      collection = all

      collection = collection.featured if category == :featured
      collection = collection.order("#{ORDER_MODES[order]} DESC")
      collection = collection.paginate(page, per_page) if page

      collection
    end
  end

  def user
    super || self.user = User.null
  end

  def stdout
    @stdout ||= BufferedStdout.new(
      stdout_data.decompressed_path,
      stdout_timing.decompressed_path
    ).lazy
  end

  def with_terminal
    terminal = Terminal.new(terminal_columns, terminal_lines)
    yield(terminal)
  ensure
    terminal.release if terminal
  end

  def theme
    theme_name.presence && Theme.for_name(theme_name)
  end

end
