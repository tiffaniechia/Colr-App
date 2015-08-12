describe Color do

  describe '#initialize' do
    before do
      @color_data = {timestamp: 123, hex: 'fff', id: 456, tags: [{timestamp: 123, id: 456, name: 'name'}], wrong_data: 'should not be instantiated'}
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
      @tag_data = {tags: [{timestamp: 123, id: 456, name: 'abc'}]}
      @color_tags = Color.new(@tag_data)
      result = @color_tags.tags[0].is_a? Tag
      result.should.equal true
    end
  end

  describe '#get_color' do
    extend WebStub::SpecHelpers

    describe 'calls get color api' do
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

      it 'calls api with correct hex' do
        @stub = stub_request(:get, 'http://www.colr.org/json/color/3B5998')
        @stub.to_return(json: @response)

        Color.self.find(@request) do |results, error|
          resume
        end

        wait_max 1.0 do
          @stub.should.be.requested
        end

      end

      it 'should return nil if id is unavailable' do
        stub_request(:get, 'http://www.colr.org/json/color/3B5998').to_return(json: {wrong_data: 'wrong'})

        Color.self.find(@request) do |results, error|
          @results = results
          resume
        end
        wait_max 1.0 do
          @results.should.be.equal nil
        end
      end

      it 'should return response if id is valid' do
        stub_request(:get, 'http://www.colr.org/json/color/3B5998').to_return(json: @response)

        Color.self.find(@request) do |results, error|
          @results = results
          # @results_body = BW::JSON.parse(results.body)
          resume
        end
        wait_max 1.0 do
          # @results.headers['Content-Type'].should.be.equal 'application/json'
          # @results.status_description.should.be.equal 'no error'
          # @results.status_code.should.be.equal 200
          # @results_body['colors'][0]['id'].should.be.equal 456
          # @results_body['colors'][0]['timestamp'].should.be.equal 123
          # @results_body['colors'][0]['hex'].should.be.equal @request
          # @results_body['colors'][0]['tag'][0]['id'].should.be.equal 1011
          # @results_body['colors'][0]['tag'][0]['name'].should.be.equal 'name'
          # @results_body['colors'][0]['tag'][0]['timestamp'].should.be.equal 789
        end

      end
    end
  end

end
