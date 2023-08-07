with Ada.Numerics.Generic_Elementary_Functions;
with Generic_Dual_Types;

generic
type Real is digits <>;
package YAA.Functions is
   package Dual_Types is new Generic_Dual_Types (Real => Real);

   package Functions_On_Real is new
      Ada.Numerics.Generic_Elementary_Functions (Real);

   function CosR (X : Real) return Real renames Functions_On_Real.Cos;
   function SinR (X : Real) return Real renames Functions_On_Real.Sin;

   function Cos (X : Dual_Types.Dual) return Dual_Types.Dual;

end YAA.Functions;
