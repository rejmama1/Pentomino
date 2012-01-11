# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'lib/problem/piece'
class TestPiece < Test::Unit::TestCase
  def test_rotation
    p = Piece.new
    p.add_line([1,0])
    p.add_line([1,1])
    p.add_line([0,1])
    p.add_line([0,1])
    p.normalize
    
    assert_equal(1,p.shape[0][0])
    assert_equal(0,p.shape[0][1])
    assert_equal(1,p.shape[1][0])
    assert_equal(1,p.shape[1][1])
    assert_equal(0,p.shape[2][0])
    assert_equal(1,p.shape[2][1])
    assert_equal(0,p.shape[3][0])
    assert_equal(1,p.shape[3][1])
    
    p = p.rotate
    p.to_s
    
    
    assert_equal(0,p.shape[0][0])
    assert_equal(0,p.shape[0][1])
    assert_equal(1,p.shape[0][2])
    assert_equal(1,p.shape[0][3])
    assert_equal(1,p.shape[1][0])
    assert_equal(1,p.shape[1][1])
    assert_equal(1,p.shape[1][2])
    assert_equal(0,p.shape[1][3])
    
    puts
    p = p.get_mirror
    p.to_s
    assert_equal(1,p.shape[0][0])
    assert_equal(1,p.shape[0][1])
    assert_equal(0,p.shape[0][2])
    assert_equal(0,p.shape[0][3])
    assert_equal(0,p.shape[1][0])
    assert_equal(1,p.shape[1][1])
    assert_equal(1,p.shape[1][2])
    assert_equal(1,p.shape[1][3])
    
    
    
  end
end
