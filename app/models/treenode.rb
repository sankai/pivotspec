require 'Pivotnode'
class Treenode < Pivotnode

  # ========================================================
  # �S��
  # ========================================================
  
  # --------------------------------------------------------
  # ������
  # --------------------------------------------------------
  def initialize
    @axises    = Hash.new()
    @children  = Array.new()
  end
  
  # --------------------------------------------------------
  # �����̃Z�b�g
  # --------------------------------------------------------
  def setAxisName(axisname)
    @axisname = axisname
  end
  
  # --------------------------------------------------------
  # ���l�̃Z�b�g
  # --------------------------------------------------------
  def setAxisValue(axisvalue)
    @axisvalue = axisvalue
  end
  
  # --------------------------------------------------------
  # �����̎擾
  # --------------------------------------------------------
  def getAxisName
    @axisname
  end
  
  # --------------------------------------------------------
  # ���l�̃Z�b�g
  # --------------------------------------------------------
  def getAxisValue
    @axisvalue
  end
  
  # --------------------------------------------------------
  # �l�̎擾�i���̏ꍇ�͎��l��Ԃ�
  # --------------------------------------------------------
  def getValue
    return self.getAxisValue()
  end
    
  # --------------------------------------------------------
  # ���̒ǉ�	
  # --------------------------------------------------------
  def addAxis(axisname, axisvalue)
    super
    self.setAxisName(axisname)
    self.setAxisValue(axisvalue)
  end
  
  # --------------------------------------------------------
  # �q�m�[�h��ǉ�����
  # --------------------------------------------------------
  def addChild( child )
    @children.push(child)
  end
  
  # --------------------------------------------------------
  # �����̎q�m�[�h��S�ĕԂ�
  # --------------------------------------------------------
  def getChildren
    return @children
  end
  
  # --------------------------------------------------------
  # �z���̃m�[�h��S�ĕԂ�
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
  # �q�m�[�h�̒ǉ�(����)
  # --------------------------------------------------------
  def addChildren( someChildren )
    someChildren.each do | child |
      self.addChild( child )
    end 
  end
  
  # --------------------------------------------------------
  # ���[�t�H�i�q�m�[�h�������Ȃ����[�m�[�h�Ȃ�true�j
  # --------------------------------------------------------
  def leaf?
    @children.empty?
  end
  
  # --------------------------------------------------------
  # �s�̖��[���ǂ����i�c���[�\���̂��߂̋@�\�j
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
  # �z���̃��[�t�̐��𐔂���
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
  # ���̓W�J
  #   �^����ꂽ����=>�l��Array�������ɁA���ʃ��x���Ɏq�m�[�h��W�J����B
  # --------------------------------------------------------
  def expand(axisname, axisvalues)
    axisvalues.each do | axisvalue |
      # �V�����m�[�h�����
      node = Treenode.new()
      # �����̎�Hash�̃N���[����V�����m�[�h�ɃZ�b�g����
      node.setAxises(self.getDupedAxises())
      # �V�����Ɉ����̎����ƒl��ǉ��ŃZ�b�g����
      node.addAxis(axisname, axisvalue)
      self.addChild(node)
    end
    return self.getChildren()
  end
  
  # --------------------------------------------------------
  # PivotNode�̐���
  #   ���[�t�m�[�h�̏ꍇ��PivotNode�̋�ۃN���X�����ƂɁA���̃C���X�^���X�𐶐�
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
