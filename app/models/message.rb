class Message < ApplicationRecord
  belongs_to :group
  belongs_to :user
  validates :content, presence: true, unless: :image?
# タイトルと本文のいずれかが空の場合は
# 保存処理が行われないというバリデーション
  # 例validates :title, :content, presence: true

  mount_uploader :image, ImageUploader

end
