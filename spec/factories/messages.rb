FactoryBot.define do
  factory :message do
    content {Faker::Lorem.sentence}
    image {File.open("#{Rails.root}/public/images/test_image.jpg")}
    # test_image.jpgはひまわりの画像です
    # publicディレクトリ /images/test_image.jpgにある パスが設定されてる
    # Rails.rootの意味は/Users/~~/アプリケーションまでのパスを取得しています
    user
    group
  end
end
