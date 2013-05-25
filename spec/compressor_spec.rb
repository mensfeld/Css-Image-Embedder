require 'spec_helper'

describe CssImageEmbedder::Compressor do

  subject { CssImageEmbedder::Compressor.new }

  context "when we have a CSS file withount anything special" do
    context "and it is in multiply lines" do
      it "should compress it" do
        css = '
          #test  { background: #ffffff; }
          #test2 { background: #000000; }
        '
        subject.compress(css).should == "#test{background:#ffffff}#test2{background:#000000}\n"
      end
    end
  end

  context "when we have CSS file without any strange stuff" do
    it "should convert std css file and embed pictures into it" do
      sass = Sass::Engine.new(css_content("std_converted"), syntax: :scss, style: :compressed)
      subject.compress(css_content("std")).should == sass.render
    end
  end

end
