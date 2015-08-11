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

   describe '#get_color' do
     extend WebStub::SpecHelpers

     describe 'get request to return json' do
        it 'retrieves colour details' do
          @request = '3B5998'
          @response = {
              colors: [
                  {
                      timestamp: 123,
                      hex: @request,
                      id: 456,
                      tag: [
                          {
                              timestamp: 789,
                              id: 1011,
                              name: 'name'
                          }
                      ]
                  }]}
          @stub = stub_request(:get, 'http://www.colr.org/json/color/3B5998')
          @stub.to_return(json: @response)


          @results = nil
          Color.self.find(@request) do |results, error|
            @results_header = results.headers
            @results_body = results.body
            resume
          end

          wait_max 1.0 do
            @stub.should.be.requested
            @results_header['Content-Type'].should.be == 'application/json'
          end
        end
     end
   end

 end
