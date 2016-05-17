require 'Faker'
require 'mongoid'
require 'digest/md5'
require 'Faker'
require 'spreadsheet'
require File.expand_path('../user.rb', __FILE__)
class  Shuijun
  def initialize
  end
  def create_user
    display_name = Faker::Name.name
    Digest::MD5.hexdigest('_cms4bonday')
        info = {
        password: Digest::MD5.hexdigest('aaaaaa'),
        email: Faker::Internet.safe_email,
        display_name: display_name,
        role: "basic",
        mobile: "11011111",
        gender: 0,
        inviteCode: "",
        inviteTimes: 0,
        beInviteTimes: 0,
        status: 1,
        type: 0,
        sort: 0,
        badges: {
            view_count: 7,
            comment_count: 0,
            praise_count: 0,
            watch_count: 0,
            collect_count: 0,
            share_count: 0,
            order_count: 0,
            user_post_count: 0,
            user_watch_count: 0,
            isCollected: false,
            isShared: false,
            isWatched: false,
            isPraised: false,
            isSigned: false
        },
        name: Faker::Name.first_name+Faker::Name.last_name ,
        properties: {}
    }
      @user = User.new(info)
      count = User.where(name: @user[:name]).count
      if count > 0
        return create_user
      end
      @user.save
      return @user
  end

end

ENV['MONGOID_ENV'] = 'development'
Mongoid.load!("/Users/icepoint1999/Desktop/shuijun/mongoid.yml")
Spreadsheet.client_encoding = 'UTF-8'
book = Spreadsheet::Workbook.new
sheet1 = book.create_worksheet
sheet1.name = 'My First Worksheet'
sheet1[0,0] = '用户名'
sheet1[0,1] = '密码'
sheet1[0,2] = '昵称'
sheet1[0,3] = '头像链接'

(0..20).each_with_index do |index,number|
  shuijun = Shuijun.new
  @user = shuijun.create_user
  sheet1[index+1,0] = @user[:name]
  sheet1[index+1,1] = 'heheda'
  sheet1[index+1,2] = @user[:display_name]
  sheet1[index+1,3] = '默认头像'
end
book.write '/Users/icepoint1999/Desktop/monica.xlsx'
