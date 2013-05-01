
"Package of classes related to constraint checking for behavior-driven development and design-by-contract.
 There are two kinds of resource in this package:

 1. Base classes for defining constraints
    `Constraint` - Defines the interface for checking a constraint as well as methods for extending 
                   the constraint via AND and OR operations.
    `BasicConstraint` - Implements a constraint with a predicate and functions that compute the
                        message to use depending on the outcome.
    `AdjectivalConstraint` - Further simplifies constraint definition to a predicate plus an
                             adjective to use in the output messages.
    `ComparisonConstraint` - Even further simplification of the messages for comparisons between the
                             actual value an an expected or comparable value.
    `AndConstraint` - Represents the conjunction of two constraints.
    `OrConstraint` - Represents the disjunction of two constraints.

 2. An enumerated family of types for representing the results of checking constraints
    `ConstraintCheckResult` - Abstract base class for hierarchy of constraint checking results.
    `ConstraintCheckSuccess` - Individual successful constraint check result.
    `ConstraintCheckFailure` - Individual failed constraint checking result.
    `ConstraintCheckUnexpectedNull` - Constraint check failure due to the actual value being unexpectedly null.
    `ConstraintCheckUnexpectedException` - Constraint checking result where an exception occurred unexpectedly.
    `ConstraintCheckComposite` - A composite result with one or more child results.
 "
by "Martin E. Nordberg III"
shared package org.justceyin.expectations.constraints;
