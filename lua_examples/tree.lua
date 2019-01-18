--[[
  I was testing out some object oriented programming in lua,
  so this class is the result of that.  I've created a standard BST
  with nodes that contain data, a left node and a right node.
]]--

Tree = {}

-- Creates a new Tree with a nil root
function Tree:new()
  local o = { root=nil }
  setmetatable(o, self)
  self.__index = self
  return o
end

-- Adds an item onto a tree
function Tree:add(o)
  if (self.root == nil) then
    self.root = Node:new{data=o}
  else
    self.root = self:recAdd(self.root, o)
  end
end

-- The recursive add function
function Tree:recAdd(node, toAdd)
  if (node == nil) then
    local newNode = Node:new{data=toAdd}
    return newNode
  elseif (toAdd < node.data) then
    node.left = self:recAdd(node.left, toAdd)
  else
    node.right = self:recAdd(node.right, toAdd)
  end
  
  return node
end

-- Called to print the tree contents inorder
function Tree:printTree()
  self:printTreeRec(self.root)
end

-- Recursive function to print the tree
function Tree:printTreeRec(node)
  if (node ~= nil) then
    self:printTreeRec(node.left)
    print(' ' .. node.data .. ' ')
    self:printTreeRec(node.right)
  end
end

-- Removes a given data element from the tree
function Tree:remove(ele)
  self.root = self:recRemove(self.root, ele)
end

-- The recursive remove function called by remove
function Tree:recRemove(node, e)
  if (node == nil) then
    return;
  elseif (node.data > e) then
    node.left = self:recRemove(node.left, e)
  elseif (node.data < e) then
    node.right = self:recRemove(node.right, e)
  else
    -- Found the node
    if (node.left == nil and node.right == nil) then
      return nil
    elseif (node.left == nil) then
      node = node.right
    elseif (node.right == nil) then
      node = node.left
    else
      -- Two children
      local pred = self:getPred(node)
      node = self:recRemove(node, pred.data)
      node.data = pred.data
    end
  end
  return node
end

-- Gets the predecessor of a given node
function Tree:getPred(node)
  node = node.left
  while (node.right) do
  	node = node.right
  end
  return node
end
    
  

-- The Node class
Node = {}

-- Creates a new node
function Node:new(o)
  local o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

-- Sets the left of the current node
function Node:setLeft(node)
  self.left = node
end

-- Sets the right of the current node
function Node:setRight(node)
  self.right = node
end

-- Sets the data of the current node
function Node:setData(d)
  self.data = d
end

-- Some tests
t = Tree:new()
t:add(5)
t:add(2)
t:add(6)
t:add(10)
t:add(1)
t:add(25)
t:add(3)
t:add(6)
t:printTree()

t:remove(10)
t:remove(2)
t:remove(6)
t:remove(3)

t:printTree()