cxx_plugin do |ruby_dsl, building_blocks, log|

  def handle_has_sources(io, building_block)
    if building_block.kind_of?(Cxxproject::HasSources)
      io.puts "pushd \"#{building_block.project_dir}\""
      Dir.chdir(building_block.project_dir) do
        building_block.collect_sources_and_toolchains.each do |source, toolchain|
          io.puts ToMake.escape_spaces(building_block.calc_command_line_for_source(source, toolchain)[0]).join(' ')
        end
      end
      io.puts building_block.calc_command_line.join(' ')
      io.puts "popd"
    end
  end

  directory ruby_dsl.build_dir

  desc 'create a makefile'
  task :tomake => ruby_dsl.build_dir do
    io = StringIO.new
    io.puts('#!/bin/sh -e')
    Cxxproject::sorted_building_blocks.each do |building_block|
      handle_has_sources(io, building_block)
    end
    File.open('make.sh', 'w') do |out|
      out.write(io.string)
    end
  end

end
