module ApplicationHelper
  # ページごとの完全なタイトルを返します。
  def full_title(page_title = '')
    base_title = "Ruby on Rails Tutorial Sample App"
    # .empty?で文字列が空かどうか
    # .nil?でobjectそのものが空かどうか
    # .blank?で...?
    if page_title.empty?
      base_title
    else
      # page_title + "|" + base_title
      # + で文字列はジョインしないほうがイケてる
      "#{page_title}|#{base_title}"
    end
  end
end
