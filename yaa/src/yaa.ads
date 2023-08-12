with Generic_Dual_Types;
with Ada.Numerics.Generic_Real_Arrays;

generic
type Real is digits <>;
package YAA is

   package Dual_Types is new Generic_Dual_Types (Real => Real);
   use Dual_Types;

   package Real_Arrays is new Ada.Numerics.Generic_Real_Arrays (Real);
   subtype Gradient_Type is Real_Arrays.Real_Vector;

   function Derivative (
      F : access function (X : Dual) return Dual;
      X : Real)
      return Real;

   function Second_Derivative (
      F : access function (X : Dual) return Dual;
      X : Real)
      return Real;

   generic
      type ArrayT is array (Positive range <>) of Dual;
      type RealArrayT is array (Positive range <>) of Real;
   function Gradient (
      F : access function (Args : ArrayT) return Dual;
      V : RealArrayT)
   return Gradient_Type;

end YAA;
