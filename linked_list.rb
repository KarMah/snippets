require 'forwardable'
class LinkedList

  attr_accessor :head

  def initialize(nodes=nil)
    case nodes
      when Array
        append(nodes)
      when Node, NilClass
        @head = nodes
      else
        raise ArgumentError
    end
  end

  def append(nodes)
    self.tap do
      nodes.each do |node|
        add(node)
      end
    end
  end

  def add(node)
    node.next = head
    self.tap {@head = node}
  end

  def delete(node)
    # If the linked list is empty then return false
    return false unless head
    # If the linked list is empty then return false
    if head == node
      @head = head.next
      return true
    end

    current = head
    while !current.nil?
      if current.next == node
        current.next=current.next.next
        return true
      else
        current = current.next
      end
    end
    return false
  end

  def find(value)
    current = head
    while !current.nil?
      return current if current.value == value
      current = current.next
    end
    return nil
  end

  def traverse
    current = head
    path = []
    until current.nil?
      path << current
      current = current.next
    end
    path.map(&:to_s).join('->')
  end

  def reverse!
    return if head.nil?

    current = head
    prev = nil
    until current.next.nil?
      _next = current.next
      current.next = prev

      prev = current
      current = _next
    end

    current.next = prev
    self.tap {@head = current}
  end

  def clone
    cloned_list = self.class.new
    return cloned_list unless head

    current = head
    until current.nil?
      cloned_list.add(Node.new(current.value))
      current = current.next
    end

    cloned_list
  end

  alias :dup :clone
end

class Node
  extend Forwardable

  attr_accessor :value, :next

  def initialize(_value)
    @value = _value
  end

  def_delegator :@value, :to_s, :to_s

  def ==(other)
    self.value == other.value
  end
end

ll = LinkedList.new([Node.new(10), Node.new(5), Node.new(15), Node.new(105)])

p ll.traverse
p (llc = ll.clone)
ll.delete(ll.find(10))
p ll.traverse
p llc.traverse

