class Dependencies < Array
  def include? dependency_name
    self.any?{|d| d.name == dependency_name}
  end
end


class Dependency
  attr_reader :name, :tags

  def initialize name, tags=nil
    @name = name
    tags = [] if tags == nil
    @tags = tags
  end

  def to_s
    @name
  end

  def ==(other_dep)
    @name = other_dep.to_s
  end
end


class ExternalDependency
  attr_reader :type, :module_name, :install_name

  def initialize type, module_name, install_name=nil
    @type = type
    @module_name = module_name
    @install_name = install_name || module_name
  end

  def to_s
    @install_name
  end

  def ==(other)
    :type == other.type &&
    :module_name == other.module_name &&
    :install_name == other.install_name
  end

  def message
    <<-EOS.undent
      Unsatisfied dependency: #{@install_name}
      Homebrew does not provide #{type.to_s.capitalize} dependencies, #{tool} does:

          #{command_line} #{@install_name}
      EOS
  end

  def install_test
    case @type
    when :python then %W{/usr/bin/env python -c import\ #{@module_name}}
    when :jruby then %W{/usr/bin/env jruby -rubygems -e require\ '#{@module_name}'}
    when :ruby then %W{/usr/bin/env ruby -rubygems -e require\ '#{@module_name}'}
    when :perl then %W{/usr/bin/env perl -e use\ #{@module_name}}
    end
  end

  private

  def tool
    case type
      when :python then 'easy_install'
      when :ruby, :jruby then 'rubygems'
      when :perl then 'cpan'
    end
  end

  def command_line
    case type
      when :python
        "easy_install install"
      when :ruby
        "gem install"
      when :perl
        "cpan -i"
      when :jruby
        "jruby -S gem install"
    end
  end
end
