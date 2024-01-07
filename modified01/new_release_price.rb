class NewReleasePrice
  def charge(days_rented)
    days_rented * 3
  end

  def frequent_renter_points(days_rented)
    # 新作を二日以上借りた場合はボーナスポイント
    days_rented > 1 ? 2 : 1
  end
end
