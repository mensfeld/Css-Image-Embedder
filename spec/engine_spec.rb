require 'spec_helper'

describe CssImageEmbedder::Engine do

  subject { CssImageEmbedder::Engine.new }

  context "when we have CSS file without any strange stuff" do
    it "should convert std css file and embed pictures into it" do
      subject.compress(css_content('std')).should === css_content("std_converted")
    end
  end

  context "when we provide too big background" do
    it "should not embed it by default" do
      subject.compress(css_content('too_big')).should === css_content("too_big")
    end

    context "but when limit is bigger" do
      subject { CssImageEmbedder::Engine.new(100*1024) }

      it "should embed it" do
        subject.compress(css_content('too_big')).should === css_content("big_converted")
      end
    end
  end

  context "when we provide css file where paths don't point to valid files" do
    it "should leave original css file structure" do
      subject.compress(css_content('file_sources_invalid')).should === css_content("file_sources_invalid")
    end
  end

end
