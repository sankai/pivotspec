require 'Pivotnode'
class Treenode < Pivotnode

  # ========================================================
  # 全般
  # ========================================================
  
  # --------------------------------------------------------
  # 初期化
  # --------------------------------------------------------
  def initialize
    @axises    = Hash.new()
    @children  = Array.new()
  end
  
  # --------------------------------------------------------
  # 軸名のセット
  # --------------------------------------------------------
  def setAxisName(axisname)
    @axisname = axisname
  end
  
  # --------------------------------------------------------
  # 軸値のセット
  # --------------------------------------------------------
  def setAxisValue(axisvalue)
    @axisvalue = axisvalue
  end
  
  # --------------------------------------------------------
  # 軸名の取得
  # --------------------------------------------------------
  def getAxisName
    @axisname
  end
  
  # --------------------------------------------------------
  # 軸値のセット
  # --------------------------------------------------------
  def getAxisValue
    @axisvalue
  end
  
  # --------------------------------------------------------
  # 値の取得（この場合は軸値を返す
  # --------------------------------------------------------
  def getValue
    return self.getAxisValue()
  end
    
  # --------------------------------------------------------
  # 軸の追加	
  # --------------------------------------------------------
  def addAxis(axisname, axisvalue)
    super
    self.setAxisName(axisname)
    self.setAxisValue(axisvalue)
  end
  
  # --------------------------------------------------------
  # 子ノードを追加する
  # --------------------------------------------------------
  def addChild( child )
    @children.push(child)
  end
  
  # --------------------------------------------------------
  # 直下の子ノードを全て返す
  # --------------------------------------------------------
  def getChildren
    return @children
  end
  
  # --------------------------------------------------------
  # 配下のノードを全て返す
  # --------------------------------------------------------
  def getAllChildren
    anArray = Array.new()
    anArray.push(self)
    if self.leaf?
      anArray.push(@node)
    else
      self.getChildren().each do | child |
        anArray.concat(child.getAllChildren())
      end
    end
    anArray
  end
  
  # --------------------------------------------------------
  # 子ノードの追加(複数)
  # --------------------------------------------------------
  def addChildren( someChildren )
    someChildren.each do | child |
      self.addChild( child )
    end 
  end
  
  # --------------------------------------------------------
  # リーフ？（子ノードを持たない末端ノードならtrue）
  # --------------------------------------------------------
  def leaf?
    @children.empty?
  end
  
  # --------------------------------------------------------
  # 行の末端かどうか（ツリー表示のための機能）
  # --------------------------------------------------------
  def endOfRow?
    if self.leaf?
      if @node.nil?
        true
      else
        false
      end
    else
      false
    end
  end
  
  # --------------------------------------------------------
  # 配下のリーフの数を数える
  # --------------------------------------------------------
  def numberOfLeaf(counter)
    num = 0
    if self.leaf?
      num = counter + 1
    else
      self.getChildren.each do | child |
        num = num + child.numberOfLeaf(counter)
      end
    end
   num
  end

  # --------------------------------------------------------
  # 軸の展開
  #   与えられた軸名=>値のArrayを引数に、下位レベルに子ノードを展開する。
  # --------------------------------------------------------
  def expand(axisname, axisvalues)
    axisvalues.each do | axisvalue |
      # 新しくノードを作る
      node = Treenode.new()
      # 自分の軸Hashのクローンを新しいノードにセットする
      node.setAxises(self.getDupedAxises())
      # 新しいに引数の軸名と値を追加でセットする
      node.addAxis(axisname, axisvalue)
      self.addChild(node)
    end
    return self.getChildren()
  end
  
  # --------------------------------------------------------
  # PivotNodeの生成
  #   リーフノードの場合はPivotNodeの具象クラスをもとに、そのインスタンスを生成
  # --------------------------------------------------------
  def generate(pivotNodeClass, anArray)
    if self.leaf?
      @node = pivotNodeClass.new()
      @node.setAxises(self.getDupedAxises())
      anArray.push(@node)
    else
      self.getChildren.each do | child |
        child.generate(pivotNodeClass, anArray)
      end
    end
  end
  
end
