desc "Update user karma"
task :update_user_karma => :environment do 
  start = Time.now

  scores = User.joins(:karma_points).sum(:value, :group => :user_id)

  scores.each do |user_id, score|
    User.find(user_id.to_i).update_attribute(:score, score.to_i)
  end
  end_time = Time.now
  p "Done in #{end_time - start}"
end
