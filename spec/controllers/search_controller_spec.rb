describe SearchController do
  tests SearchController

  before do
    @controller = SearchController.new
  end

  it 'is a UIViewController'do
    @controller.viewDidLoad
    result = @controller.is_a? UIViewController
    result.should.equal true
  end

  it 'should have title "Color"' do
    @controller.viewDidLoad
    @controller.title.should.equal 'Search'
  end

end