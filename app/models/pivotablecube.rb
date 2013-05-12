require 'Treenode'
class Pivotablecube  #< ActiveRecord::Base

  # ========================================================
  # 全般
  # ========================================================
  
  # --------------------------------------------------------
  # 初期化
  # --------------------------------------------------------
  def initialize
    @axises    = Hash.new()
    @nodes     = Array.new()
    @treeNodes = Array.new()
  end

  # --------------------------------------------------------
  # ツリーのルートノードを返す
  # --------------------------------------------------------
  def getRootNode
    @rootnode
  end
  
  # --------------------------------------------------------
  # 軸の情報全体を返す
  # --------------------------------------------------------
  def getAxises
    @axises
  end

  # --------------------------------------------------------
  # 軸名の一覧を返す
  # --------------------------------------------------------
  def getAxisNames
    @axises.keys
  end

  # --------------------------------------------------------
  # 全ての（末端のアプリの）ノードを返す
  # --------------------------------------------------------
  def getAllNodes
    @nodes
  end
  # --------------------------------------------------------
  # 軸の追加  
  #   axisname：  軸名（String
  #   axisvalues: 軸の値（Array)
  # --------------------------------------------------------
  def addAxis(axisname, axisvalues)
    if axisname.class != String
      raise "usage error"
    end
    if axisvalues.class != Array
      raise "usage error"
    end
    @axises.store(axisname, axisvalues)
  end

  # --------------------------------------------------------
  # ノードクラスの設定
  # --------------------------------------------------------
  def defineNodeClass(aClass)
    @nodeClass = aClass
  end

  # --------------------------------------------------------
  # キューブの作成
  # --------------------------------------------------------
  def createcube()
  
    # 事前準備
    currentLevel  = Array.new()
    previousLevel = Array.new()

    @rootnode     = Treenode.new()
    previousLevel.push(@rootnode)
    
    # ツリー構築
    @axises.each do | axisname, axisvalues |
      previousLevel.each do | mother |
        currentLevel.concat(mother.expand(axisname, axisvalues))
      end
      # 現レベルを上位レベルに昇格させる
      previousLevel = currentLevel
      currentLevel  = Array.new()
    end
    # ツリーのリーフノードに引数のクラスのインスタンスを作成
    @rootnode.generate(@nodeClass, @nodes)

  end
  
  # --------------------------------------------------------
  # 内容の出力	
  # --------------------------------------------------------
  def to_s
    s = String.new()
    @nodes.each do | node |
      s = s + node.to_s + '/'
    end
    puts 'number of @nodes ' + @nodes.size().to_s
    return s
  end
  
end
