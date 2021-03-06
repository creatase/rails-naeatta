module IntegrationHelpers
  # テストユーザーがログイン中の場合にtrueを返す
  def is_logged_in?
    !session[:user_id].nil?
  end

  # テストユーザーとしてログインする
  def log_in_as(user, email: user.email, password: "password", remember_me: "1")
    post login_path, params: {
      session: {
        email: email,
        password: password,
        remember_me: remember_me,
      },
    }
  end
end
