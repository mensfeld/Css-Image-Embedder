require 'spec_helper'

describe CssImageEmbedder::Image do

  let(:url){ '/assets/dir/bg.png' }
  let(:css_url){ "url('#{url}')" }

  subject { CssImageEmbedder::Image.new(css_url, Rails.root) }

  describe '#css_url' do
    it 'should be the same as base css url' do
      subject.css_url.should == css_url
    end
  end

  describe '#url' do
    it 'should extract only the url' do
      subject.url.should == url
    end
  end

  describe '#ext' do
    context 'when there is an extension' do
      it 'should return it' do
        subject.ext.should == 'png'
      end
    end

    context 'when there is no extension' do
      before { subject.instance_variable_set('@url', '') }

      it 'should return empty string' do
        subject.ext.should == ''
      end
    end
  end

  describe '#file_path' do
    context 'when this is an http absolute path' do
      it 'should return valid file path' do
        subject.file_path.should == "#{Rails.root}/assets/images/dir/bg.png"
      end
    end

    context 'when this is an http local path' do
      before { subject.instance_variable_set('@url', ".#{subject.url}") }

      it 'should return valid file path' do
        subject.file_path.should == "#{Rails.root}/assets/images/dir/bg.png"
      end
    end
  end

end
