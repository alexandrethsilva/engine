importScripts "../vendor/c.js"

cachedVars = {}

astFunctions =
  
  execute: (ast) =>
    for vs in ast.vars
      @_execute vs
    for cs in ast.constraints
      @_execute cs
  
  _execute: (ast) =>
    for node in ast
      func = @[node[0]]
      for sub, i in node[1...node.length]
        if sub instanceof Array # then recurse
          node[i] = @_execute sub
      return func.apply @, node[1...a.length]
  
  
  var: (id, prop, context) ->
    if cachedVars[id]
      return cachedVars[id]
    v = new c.Variable {name:id}
    cachedVars[id] = v
    return v
  
  get: (id) ->
    if cachedVars[id]
      return cachedVars[id]
    throw new Error("AST method 'get' couldn't find var with id: #{id}")
      
  plus: (e1,e2) ->
    return c.plus e2, e2 
  
  minus : (e1,e2) ->
    return c.minus e2, e2 
    
  multiply: (e1,e2) ->
    return c.plus e1, e2
    
  divide: (e1,e2,s,w) ->
    return c.divide e1, e2
  
  strength: (s) ->
    strength = c.Strength[s]
    return strength
  
  eq: (e1,e2,s,w) =>    
    return new c.Equation e1, e2, @strength(s), w
  
  lte: (e1,e2,s,w) =>    
    return new c.Inequality e1, c.LEQ, e2, @strength(s), w
  
  gte: (e1,e2,s,w) =>    
    return new c.Inequality e1, c.GEQ, e2, @strength(s), w
  
  lt: (e1,e2,s,w) =>    
    return new c.Inequality e1, c.LEQ, e2, @strength(s), w
  
  gt: (e1,e2,s,w) =>    
    return new c.Inequality e1, c.GEQ, e2, @strength(s), w

onmessage = (ast) ->
  # TODO: Include Cassowary, solve
  if ast.constraints.length isnt null
    #if c.Equation isnt null
    postMessage(
      a: 7
      b: 5
      c: 2
    )
  else
    postMessage(
      a: 1
      b: 1
      c: 1
    )