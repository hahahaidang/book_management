class Search < ActiveRecord::Base
  def self.func_search(para)
    sql = "select r.quantity, r.status, r.created_at, u.`user_name`, b.`book_name`
          from requests r, books b, users u
          where b.book_name like '#{para}' AND r.book_id=b.id and r.user_id = u.id"
    return ActiveRecord::Base.connection.exec_query(sql)
  end

end