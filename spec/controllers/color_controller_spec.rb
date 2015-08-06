describe ColorController do
  tests ColorController

  before do
    @controller = ColorController.new
  end

  it 'is a UIViewController'do
    @controller.viewDidLoad
    result = @controller.is_a? UIViewController
    result.should.equal true
  end

  it 'should have title "Color"' do
    @controller.viewDidLoad
    @controller.title.should.equal 'Color'
  end

end