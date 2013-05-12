class MenuController < ApplicationController

  # --------------------------------------------------------
  # 開始画面
  # --------------------------------------------------------  
  def start

  end

  # --------------------------------------------------------
  # スタートボタンクリック後	
  # --------------------------------------------------------  
  def started
    reset_session
    redirect_to :controller => 'carspecs', :action => 'createAxises'
  end
end
