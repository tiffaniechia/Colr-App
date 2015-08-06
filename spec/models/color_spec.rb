 describe Color do

   describe '#initialize' do
     before do
       @color_data = {timestamp:123, hex:'fff', id:456, tags: [{timestamp:123,id:456,name:'name'}], wrong_data:'should not be instantiated'}
       @color = Color.new(@color_data)
     end

     it 'should only initialize timestamp, hex, id, tags' do
       @color.timestamp.should.equal 123
       @color.hex.should.equal 'fff'
       @color.id.should.equal 456
       @color.tags.count.should.equal 1
     end

     it 'should not initialize non-required parameters' do
       @color.instance_variables.count.should.equal 4
     end
   end

   describe '#tags' do
     it 'should always return an array for tags' do
       @empty_tag_data = {}
       @empty_tag = Color.new(@empty_tag_data)
       @empty_tag.tags.should.equal []
     end

     it 'should create every tag as a tag object' do
        @tag_data = {tags:[{timestamp:123,id:456,name:'abc'}]}
        @color_tags = Color.new(@tag_data) 
        result = @color_tags.tags[0].is_a? Tag
        result.should.equal true
     end
   end

 end
