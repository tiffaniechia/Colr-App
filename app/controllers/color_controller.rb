class ColorController < UIViewController
  attr_accessor :color

  def initWithColor(color)
    initWithNibName(nil, bundle: nil)
    self.color = color
    self
  end

  def viewDidLoad
    super
    self.title = self.color.hex
    self.edgesForExtendedLayout = UIRectEdgeNone
    create_views
    add_views [@info_container, @color_view, @color_label, @text_field, @add, @table_view]
  end

  def create_views
    create_color_info_container
    create_color_view
    create_color_label
    create_tag_field
    create_add_button
    create_color_tags_table
  end

  def add_views(views)
    views.each { |view|
      self.view.addSubview view
    }
  end

  def create_tag_field
    @text_field = UITextField.alloc.initWithFrame [[110, 60], [100, 26]]
    @text_field.placeholder = 'tag'
    @text_field.textAlignment = UITextAlignmentCenter
    @text_field.autocapitalizationType = UITextAutocapitalizationTypeNone
    @text_field.borderStyle = UITextBorderStyleLine
  end

  def create_color_label
    @color_label = UILabel.alloc.initWithFrame [[110, 30], [0, 0]]
    @color_label.text = self.color.hex
    @color_label.sizeToFit
  end

  def create_color_view
    @color_view = UIView.alloc.initWithFrame [[10, 10], [90, 90]]
    @color_view.backgroundColor = String.new(self.color.hex).to_color
  end

  def create_color_info_container
    @info_container = UIView.alloc.initWithFrame [[0, 0],[self.view.frame.size.width, 110]]
    @info_container.backgroundColor = UIColor.lightGrayColor
  end

  def create_add_button
    @add = UIButton.buttonWithType UIButtonTypeRoundedRect
    @add.setTitle('Add', forState: UIControlStateNormal)
    @add.setTitle('Adding...', forState: UIControlStateDisabled)
    @add.setTitleColor(UIColor.lightGrayColor, forState: UIControlStateDisabled)
    @add.sizeToFit
    @add.frame = [[@text_field.frame.origin.x + @text_field.frame.size.width + 10, @text_field.frame.origin.y], @add.frame.size]
  end

  def create_color_tags_table
    table_frame = [[0, @info_container.frame.size.height],
                   [self.view.bounds.size.width, self.view.bounds.size.height - @info_container.frame.size.height - self.navigationController.navigationBar.frame.size.height]]
    @table_view = UITableView.alloc.initWithFrame table_frame, style: UITableViewStylePlain
  end
end
