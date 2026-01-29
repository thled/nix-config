; inherits: ecma,_typescript,_jsx

(class
  name: (type_identifier) @type.definition)
(class_declaration
  name: (type_identifier) @type.definition)
(interface_declaration
  name: (type_identifier) @type.definition)
(type_alias_declaration
  name: (type_identifier) @type.definition)
(enum_declaration
  name: (identifier) @type.definition)
(abstract_class_declaration
  name: (type_identifier) @type.definition)

(call_expression
  function: (identifier) @function.call)
(call_expression
  function: (member_expression
    property: (property_identifier) @function.method.call))
(call_expression
  function: (member_expression
    property: (private_property_identifier) @function.method.private.call))
