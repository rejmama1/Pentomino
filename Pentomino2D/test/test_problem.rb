# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'lib/problem/pentomino'
require 'lib/problem/coordinate'

class TestProblem < Test::Unit::TestCase
  def test_put
    problem = Pentomino.new("test/test_sample3.txt")
    p=problem.pieces[1].rotate
    p=p.rotate
    assert_equal(true, problem.put_piece(p, 1, 0, 0))
    assert_equal(true, problem.put_piece(p, 1, 0, 3))
    assert_equal(1,problem.find_free_place.row)
    assert_equal(1,problem.find_free_place.col)
    problem.show_board
  end
end
