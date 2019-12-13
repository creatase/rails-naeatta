module SystemHelpers
  # テストユーザーを有効化する
  def activate(user)
    user.update_attribute(:activated, true)
    user.update_attribute(:activated_at, Time.zone.now)
  end
end
