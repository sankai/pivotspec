# -*- encoding: UTF-8 -*-
# ----------------------------------------------------------
# Pivotablecubeクラスのテスト
# ----------------------------------------------------------
$LOAD_PATH.push('C:\work\pivotspec\app\models')
$LOAD_PATH.push('.')

require 'Pivotablecube'
require 'Caroption'
#require 'Carspec'

describe Pivotablecube, "when creation" do
  before do
    @pivotableCube = Pivotablecube.new()
    #@pivotableCube.initialize()
    @pivotableCube.addAxis('車種', ['100W', '200W', '300W', '400W', '500W'])
    @pivotableCube.addAxis('仕向地', ['N-America', 'Rossia', 'India', 'Thai'])
    @pivotableCube.addAxis('Grade', ['STD', 'Sports'])
    @pivotableCube.addAxis('Engine', ['1800cc', '200cc', '2500cc'])
    @pivotableCube.defineNodeClass(Caroption)
    @pivotableCube.createcube()
  end

  it "should be created" do
    puts 'created'
    puts @pivotableCube.to_s
    puts 'numberOfleaf '
    counter = 0
    counter = @pivotableCube.getRootNode().numberOfleaf(counter)
    puts counter.to_s
    puts 'numberOfNodes'
    puts @pivotableCube.getRootNode().getAllChildren().size.to_s
  end

  after do
    @pivotableCube = nil
  end
end
