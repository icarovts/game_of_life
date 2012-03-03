#Any live cell with fewer than two live neighbours dies, as if caused by underpopulation.
#Any live cell with more than three live neighbours dies, as if by overcrowding.
#Any live cell with two or three live neighbours lives on to the next generation.
#Any dead cell with exactly three live neighbours becomes a live cell.

require 'life'

describe Life do
  
  let :a_board do
    Life.new %w[
      ....
      .**.
      ....
    ]
  end

  it 'should have a board' do
    subject.board.should == [
      %w{. . . . . . . .},
      %w{. . . . . . . .},
      %w{. . . . . . . .},
      %w{. . . . . . . .}
    ]
  end
  
  it 'should be able to receive a board' do
    subject = Life.new %w[.... .... ..*. ..**]
    subject.board.should == [
      %w{. . . .},
      %w{. . . .},
      %w{. . * .},
      %w{. . * *}
    ]
  end
  
  context "when finding neighbours" do
    it "should get neighbours for one cell" do
      a_board.neighbours_for(1,1).should == %w[. . . . * . . .]
    end
    
    it "should not fail if doesn't have top neighbours" do
      a_board.neighbours_for(0, 1).should == %w[. . . * *]
    end
    
    it "should not fail if doesn't have left neighbours" do
      a_board.neighbours_for(0, 0).should == %w[. . *]
    end
    
    it "should not fail if doesn't have bottom neighbours" do
      a_board.neighbours_for(2, 1).should == %w[. * * . .]
    end
    
    it "should not fail if doesn't have right neighbours" do
      a_board.neighbours_for(2, 3).should == %w[* . .]
    end
  end
  
  context "when there are less than two live neighbours" do
    it 'should calculate the next generation (dead) for one cell' do
      a_board.next_generation_for(1, 1).should == "."
    end
    
    it 'should die' do
      a_board.next_generation!
      a_board.board.flatten.should_not include("*")
    end  
  end
  
  context "when there are more than three live neighbours" do
    let :overcrowded_life do
      Life.new %w[
        ....
        ***.
        .**.
      ]
    end
    
    it "should kill the cell" do
      overcrowded_life.next_generation_for(1,1).should == "."
    end
    
  end
  
  context "when there are three live neighbours" do
    subject do
      Life.new %w[
        ....
        ***.
        .**.
      ]
    end
    
    it "should stay alive if cell is alive" do
      subject.next_generation_for(1, 0).should == "*"
    end 
    
    it "should stay dead if cell is dead" do
      subject.next_generation_for(0, 2).should == "."
    end
  end
  
  context "when there are two live neighbours" do
    subject do
      Life.new %w[
        ....
        ***.
        .**.
      ]
    end
  end
end
