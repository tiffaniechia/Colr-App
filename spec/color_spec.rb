 describe Color do

   before do
     @color_data = {timestamp:123, hex:'fff', id:456, tags: %w(one two), wrong_data:'should not be instantiated'}
     @color = Color.new(@color_data)
   end

   it 'should initialize timestamp, hex, id, tags' do
     @color.timestamp.should == 123
     @color.hex.should == 'fff'
     @color.id.should == 456
     @color.tags.count.should == 2
   end

   it 'should not initialize non-required parameters' do
    @color.instance_variables.count.should == 4
   end
 end
