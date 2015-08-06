describe Tag do

  before do
    @tags_data = {timestamp: 'timestamp', id: 123, name: 'name', wrong_data:'wrong'}
    @tag = Tag.new(@tags_data)
  end

  it 'should only take timestamp, id, and name' do
    @tag.timestamp.should.equal 'timestamp'
    @tag.id.should.equal 123
    @tag.name.should.equal 'name'
    @tag.instance_variables.count.should.equal 3
  end

end