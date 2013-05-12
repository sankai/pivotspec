require 'Treenode'
class Pivotablecube  #< ActiveRecord::Base

  # ========================================================
  # �S��
  # ========================================================
  
  # --------------------------------------------------------
  # ������
  # --------------------------------------------------------
  def initialize
    @axises    = Hash.new()
    @nodes     = Array.new()
    @treeNodes = Array.new()
  end

  # --------------------------------------------------------
  # �c���[�̃��[�g�m�[�h��Ԃ�
  # --------------------------------------------------------
  def getRootNode
    @rootnode
  end
  
  # --------------------------------------------------------
  # ���̏��S�̂�Ԃ�
  # --------------------------------------------------------
  def getAxises
    @axises
  end

  # --------------------------------------------------------
  # �����̈ꗗ��Ԃ�
  # --------------------------------------------------------
  def getAxisNames
    @axises.keys
  end

  # --------------------------------------------------------
  # �S�Ắi���[�̃A�v���́j�m�[�h��Ԃ�
  # --------------------------------------------------------
  def getAllNodes
    @nodes
  end
  # --------------------------------------------------------
  # ���̒ǉ�  
  #   axisname�F  �����iString
  #   axisvalues: ���̒l�iArray)
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
  # �m�[�h�N���X�̐ݒ�
  # --------------------------------------------------------
  def defineNodeClass(aClass)
    @nodeClass = aClass
  end

  # --------------------------------------------------------
  # �L���[�u�̍쐬
  # --------------------------------------------------------
  def createcube()
  
    # ���O����
    currentLevel  = Array.new()
    previousLevel = Array.new()

    @rootnode     = Treenode.new()
    previousLevel.push(@rootnode)
    
    # �c���[�\�z
    @axises.each do | axisname, axisvalues |
      previousLevel.each do | mother |
        currentLevel.concat(mother.expand(axisname, axisvalues))
      end
      # �����x������ʃ��x���ɏ��i������
      previousLevel = currentLevel
      currentLevel  = Array.new()
    end
    # �c���[�̃��[�t�m�[�h�Ɉ����̃N���X�̃C���X�^���X���쐬
    @rootnode.generate(@nodeClass, @nodes)

  end
  
  # --------------------------------------------------------
  # ���e�̏o��	
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
