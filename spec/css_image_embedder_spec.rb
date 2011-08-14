require 'spec_helper'

ROOT = File.expand_path(File.dirname(__FILE__))
FILES_ROOT = File.join(ROOT, 'files')

def file_content(f)
  file = File.new("#{f}", "r")
  content = ''
  while (line = file.gets)
    content+=line
  end
  content
end

def files_equal?(f1, f2)
  file_content(f1) == file_content(f2)
end

describe CssImageEmbedder::Converter do

  subject { CssImageEmbedder::Converter }

  # Should clear all css files created in test
  after(:all) do
    FileUtils.rm("#{ROOT}/std.css")
  end

  context "when we have CSS file without any strange stuff" do
    it "should convert std css file and embed pictures into it" do
      converter = subject.new(
        :path => "#{FILES_ROOT}/std.css",
        :overwrite => true, 
        :root => ROOT
      )
      converter.convert
      converter.result.should === file_content("#{FILES_ROOT}/std_converted.css")
    end

    context "and allow to overwrite" do
      it "should embed backgrounds and overwrite source file" do
        # Copy std.css to check if it will be overwritten
        FileUtils.cp("#{FILES_ROOT}/std.css", "#{ROOT}/std.css")
        converter = subject.new(
          :path => "#{ROOT}/std.css",
          :overwrite => true,
          :root => ROOT
        )
        converter.convert
        converter.save
        converter.result.should == file_content("#{ROOT}/std.css")
        converter.result.should == file_content("#{FILES_ROOT}/std_converted.css")
      end
    end

  end

  context "when we provide too big background" do
    it "should not embed it by default" do
      converter = subject.new(
        :path => "#{FILES_ROOT}/too_big.css",
        :overwrite => true,
        :root => ROOT
      )
      converter.convert
      converter.result.should === file_content("#{FILES_ROOT}/too_big.css")
    end

    context "but limit is bigger" do
      it "should embed it" do
      converter = subject.new(
        :path => "#{FILES_ROOT}/too_big.css",
        :overwrite => true,
        :root => ROOT,
        :img_max_size => 100*1024
      )
      converter.convert
      converter.result.should === file_content("#{FILES_ROOT}/big_converted.css")
      end
    end
  end

  context "when we provide css file where paths don't point to valid files" do
    it "should leave original css file structure" do
      converter = subject.new(
        :path => "#{FILES_ROOT}/file_sources_invalid.css",
        :root => ROOT
      )
      converter.convert
      converter.result.should == file_content("#{FILES_ROOT}/file_sources_invalid.css")
    end
  end

  context "when we don't provide root path" do
    it "should raise RootPathNotProvided" do
      lambda {
        subject.new(
          :path => "#{FILES_ROOT}/std_converted.css"
        )
      }.should raise_exception(RootPathNotProvided)
    end
  end

  context "when we provide invalid source css file" do
    it "should raise Exceptions::CssNotFound" do
      lambda {
        subject.new(
          :path => "#{FILES_ROOT}no_file.css"
        )
      }.should raise_exception(CssNotFound)
    end

    context "but we provide string containing css" do
      it "should convert it from string" do
        converter = subject.new(
          :source => file_content("#{FILES_ROOT}/std.css"),
          :root => ROOT
        )
        converter.convert
        converter.result.should == file_content("#{FILES_ROOT}/std_converted.css")
      end
    end

    context "when we try to convert file to base64" do
      it "should convert it" do
        subject.file_to_base64("#{FILES_ROOT}/bg.png").should == file_content("#{FILES_ROOT}/bg_base64.png").gsub("\n", '')
      end
    end

    context "when we provide huge one liner" do
      it "should convert it without hesitation" do
        converter = subject.new(
          :path => "#{FILES_ROOT}/oneliner.css",
          :root => ROOT
        )
        converter.convert
        converter.result.should == file_content("#{FILES_ROOT}/oneliner_converted.css")
      end
    end
  end
  
end

describe CssImageEmbedder::Compressor do

  subject { CssImageEmbedder::Compressor }

  context "when we have a CSS file withount anything special" do
    context "and it is in multiply lines" do
      it "should compress it" do
        s = subject.new(ROOT)
        css = '
          #test  { background: #ffffff; }
          #test2 { background: #000000; }
        '
        s.compress(css).should == "#test{background:#ffffff}#test2{background:#000000}\n"
      end
    end
  end

  context "when we have CSS file without any strange stuff" do
    it "should convert std css file and embed pictures into it" do
      s = subject.new(ROOT)
      sass = Sass::Engine.new(file_content("#{FILES_ROOT}/std_converted.css"), :syntax => :scss, :style => :compressed)
      s.compress(file_content("#{FILES_ROOT}/std.css")).should=== sass.render
    end
  end
  
end