module SystemHelpers
  # テストユーザーを有効化する
  def activate(user)
    user.update_attributes(activated: true, activated_at: Time.zone.now)
  end
end
