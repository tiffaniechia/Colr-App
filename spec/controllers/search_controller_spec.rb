describe SearchController do
  tests SearchController

  describe 'inital loaded details' do
    before do
      @controller = SearchController.new
      @controller.viewDidLoad
      @controller_width = @controller.view.frame.size.width
      @controller_height = @controller.view.frame.size.height
    end

    it 'is a UIViewController'do
      result = @controller.is_a? UIViewController
      result.should.equal true
    end

    it 'should have title "Color"' do
      @controller.title.should.equal 'Search'
    end

    it 'should have a white background' do
      @controller.view.backgroundColor.should.equal UIColor.whiteColor

    end

    it 'should have a text field with default styling' do
      @text_field = @controller.view.subviews[0]
      result = @text_field.is_a? UITextField
      result.should.equal true

      @text_field.placeholder.should.equal '#abcabc'
      @text_field.textAlignment.should.equal UITextAlignmentCenter
      @text_field.autocapitalizationType.should.equal UITextAutocapitalizationTypeNone
      @text_field.borderStyle.should.equal UITextBorderStyleRoundedRect


      text_field_width = @controller_width/2
      text_field_height = @controller_height/2 -100

      @text_field.center.x.should.equal text_field_width
      @text_field.center.y.should.equal text_field_height
    end

    it 'should have submit button with default styling' do
      @search_button = @controller.view.subviews[1]
      result = @search_button.is_a? UIButton
      result.should.equal true

      search_button_width = @controller_width/2
      search_button_height = @controller.view.subviews[0].center.y + 40

      @search_button.center.x.should.equal search_button_width
      @search_button.center.y.should.equal search_button_height
    end
  end

  describe '#rip_hex' do
    controller = SearchController.new
    hex = controller.rip_hex('#abcd')
    hex.should.equal 'abcd'
  end

  describe '#button_touch_event' do
    it 'should disable state' do
      tap 'Search'
      controller.instance_variable_get("@was_tapped").should.equal true
    end
  end
end