class SearchController < UIViewController

  def viewDidLoad
    super
    self.title = 'Search'
    self.view.backgroundColor = UIColor.whiteColor

    create_views
    add_views [@text_field, @search_button]

    create_button_touch_event
  end

  def create_button_touch_event
    @search_button.when(UIControlEventTouchUpInside) do
      @was_tapped = true
      @search_button.enabled = false
      @text_field.enabled = false
      reformatted_hex = rip_hex(@text_field.text)
      Color.find(reformatted_hex) do |color|
        @finding_color = true
        @search_button.enabled = true
        @text_field.enabled = true
      end
    end
  end

  def rip_hex(hex)
    hex[1..-1] if hex[0] == '#'
  end

  def create_views
    create_text_field
    create_submit_button
  end

  def create_text_field
    @text_field = UITextField.alloc.initWithFrame [[0, 0], [160, 26]]
    @text_field.placeholder = '#abcabc'
    @text_field.textAlignment = UITextAlignmentCenter
    @text_field.autocapitalizationType = UITextAutocapitalizationTypeNone
    @text_field.borderStyle = UITextBorderStyleRoundedRect
    @text_field.center = CGPointMake self.view.frame.size.width/2, self.view.frame.size.height/2 -100
  end

  def create_submit_button
    @search_button = UIButton.buttonWithType UIButtonTypeRoundedRect
    @search_button.accessibilityLabel = 'Searchh'
    @search_button.setTitle 'Search', forState: UIControlStateNormal
    @search_button.setTitle 'Loading', forState: UIControlStateDisabled
    @search_button.sizeToFit
    @search_button.center = CGPointMake self.view.frame.size.width/2, @text_field.center.y+40
  end

  def add_views(views)
    views.each { |view|
      self.view.addSubview view
    }
  end

end