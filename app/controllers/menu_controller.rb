class MenuController < ApplicationController

  # --------------------------------------------------------
  # �J�n���
  # --------------------------------------------------------  
  def start

  end

  # --------------------------------------------------------
  # �X�^�[�g�{�^���N���b�N��	
  # --------------------------------------------------------  
  def started
    reset_session
    redirect_to :controller => 'carspecs', :action => 'createAxises'
  end
end
