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
    @install_name = install_name or module_name
  end

  def to_s
    @install_name
  end

  def ==(other)
    :type == other.type &&
    :module_name == other.module_name &&
    :install_name == other.install_name
  end
end
