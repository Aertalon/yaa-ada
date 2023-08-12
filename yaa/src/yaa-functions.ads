with Ada.Numerics.Generic_Elementary_Functions;

generic
package YAA.Functions is

   package Dual_Types renames YAA.Dual_Types;

   package Functions_On_Real is new
      Ada.Numerics.Generic_Elementary_Functions (Real);

   function PowerR (X : Real; Q : Real) return Real
      renames Functions_On_Real."**";

   function SqrtR (X : Real) return Real renames Functions_On_Real.Sqrt;
   function LogR (X : Real) return Real renames Functions_On_Real.Log;
   function ExpR (X : Real) return Real renames Functions_On_Real.Exp;

   function CosR (X : Real) return Real renames Functions_On_Real.Cos;
   function SinR (X : Real) return Real renames Functions_On_Real.Sin;
   function TanR (X : Real) return Real renames Functions_On_Real.Tan;
   function CotR (X : Real) return Real renames Functions_On_Real.Cot;

   function ArccosR (X : Real) return Real renames Functions_On_Real.Arccos;
   function ArcsinR (X : Real) return Real renames Functions_On_Real.Arcsin;
   function ArctanR (X : Real; Y : Real := Real (1.0)) return Real
      renames Functions_On_Real.Arctan;
   function ArccotR (X : Real; Y : Real := Real (1.0)) return Real
      renames Functions_On_Real.Arccot;

   function CoshR (X : Real) return Real renames Functions_On_Real.Cosh;
   function SinhR (X : Real) return Real renames Functions_On_Real.Sinh;
   function TanhR (X : Real) return Real renames Functions_On_Real.Tanh;
   function CothR (X : Real) return Real renames Functions_On_Real.Coth;

   function ArccoshR (X : Real) return Real renames Functions_On_Real.Arccosh;
   function ArcsinhR (X : Real) return Real renames Functions_On_Real.Arcsinh;
   function ArctanhR (X : Real) return Real renames Functions_On_Real.Arctanh;
   function ArccothR (X : Real) return Real renames Functions_On_Real.Arccoth;

   function Power (X : Dual; Q : Real) return Dual;

   function Sqrt (X : Dual) return Dual;
   function Log (X : Dual) return Dual;
   function Exp (X : Dual) return Dual;

   function Cos (X : Dual) return Dual;
   function Sin (X : Dual) return Dual;
   function Tan (X : Dual) return Dual;
   function Cot (X : Dual) return Dual;

   function Arccos (X : Dual) return Dual;
   function Arcsin (X : Dual) return Dual;
   function Arctan (X : Dual) return Dual;
   function Arccot (X : Dual) return Dual;

   function Cosh (X : Dual) return Dual;
   function Sinh (X : Dual) return Dual;
   function Tanh (X : Dual) return Dual;
   function Coth (X : Dual) return Dual;

   function Arccosh (X : Dual) return Dual;
   function Arcsinh (X : Dual) return Dual;
   function Arctanh (X : Dual) return Dual;
   function Arccoth (X : Dual) return Dual;

end YAA.Functions;
