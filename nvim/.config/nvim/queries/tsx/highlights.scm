; inherits: typescript,jsx

(lexical_declaration
    (variable_declarator
      name: (identifier) @variable.definition))

(lexical_declaration
  (variable_declarator
    name: (array_pattern
            (identifier) @variable.definition)))
