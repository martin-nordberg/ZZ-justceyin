"
 Package containing predefined providers of constraints for built-in Ceylon types.

 Concrete Constraint Providers

 * `aBoolean` - Constraints on Boolean values.
 * `aDate` - Constraints on Date values (from ceylon.time).
 * `aDateTime` - Constraints on DateTime values (from ceylon.time).
 * `aFloat` - Constraints specific to floating point numbers.
 * `anInteger` - Constraints for integers.
 * `aString` - Constraints on strings.
 * `aWhole` - Constraints on whole numbers (from ceylon.math).

 Abstract Constraint Providers

 * `CategoryConstraints` - Constraints related to Ceylon's Category class (mixin).
 * `CollectionConstraints` - Constraints related to Ceylon collections (mixin).
 * `ComparableConstraints` - Comparison constraints based on Ceylon's Comparable interface.
 * `EqualityConstraints` - Provider of constraints for checking equality.
 * `IntegralConstraints` - Constraints on types derived from Ceylon's Integral (mixin).
 * `ListConstraints` - Constraints on lists (mixin).
 * `NumberConstraints` - Constraints on general numbers (mixin).
"
by "Martin E. Nordberg III"
shared package org.justceyin.expectations.constraints.providers;
