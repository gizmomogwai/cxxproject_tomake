require 'cxxproject_tomake/to_make'

describe ToMake do

  it 'should replace paths after -L' do
    ToMake.escape_spaces(['-Ltest 123']).should == ['-L"test 123"']
  end

  it 'should replace paths after -I' do
    ToMake.escape_spaces(['-Itest 123']).should == ['-I"test 123"']
  end

end
