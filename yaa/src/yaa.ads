with Generic_Dual_Types;

generic
type Real is digits <>;
package YAA is
   package Dual_Types is new Generic_Dual_Types (Real => Real);
   use Dual_Types;

   function Derivative (
      F : access function (X : Dual) return Dual;
      X : Real)
      return Real;

   function Second_Derivative (
      F : access function (X : Dual) return Dual;
      X : Real)
      return Real;
end YAA;
