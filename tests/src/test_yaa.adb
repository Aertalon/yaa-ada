with Ada.Numerics.Generic_Elementary_Functions;

with AUnit.Assertions;
with AUnit.Test_Caller;

with YAA;
with YAA.Functions;

package body Test_Yaa is

   use AUnit.Assertions;

   package Caller is new AUnit.Test_Caller (Test);

   Test_Suite : aliased AUnit.Test_Suites.Test_Suite;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Name : constant String := "(Dual numbers test) ";
   begin
      Test_Suite.Add_Test (Caller.Create
         (Name & "YAA: Example usage", Test_Sample'Access));
      Test_Suite.Add_Test (Caller.Create
         (Name & "YAA: Example usage for gradient", Test_Gradient'Access));

      return Test_Suite'Access;
   end Suite;

   procedure Test_Sample (Object : in out Test) is
      package YAA_F is new YAA (Real => Float);
      package YAA_Functions_F is new YAA_F.Functions;

      package Functions_On_Float is new
         Ada.Numerics.Generic_Elementary_Functions (Float);

      generic
         type T is private;
         with function "*" (X : T; Y : T) return T;
         with function CosT (X : T) return T;
      function F (X : T) return T;

      function F (X : T) return T is
      begin
         return CosT (X * X);
      end F;

      function F_Dual is new F (
         T => YAA_F.Dual_Types.Dual,
         "*" => YAA_F.Dual_Types."*",
         CosT => YAA_Functions_F.Cos);

   begin
      declare
         X : constant Float := 3.0;
      begin

         --  f(x) = cos(x^2)
         --  f'(x) = -2xsin(x^2)
         --  f''(x) = -2sin(x^2) - 4x^2cos(x^2)
         Assert (
            YAA_F.Derivative (F_Dual'Access, X) =
               -2.0 * X * Functions_On_Float.Sin (X * X),
            "YAA Example usage test failed: derivative");

         Assert (
            YAA_F.Second_Derivative (F_Dual'Access, X) =
               -2.0 * Functions_On_Float.Sin (X**2)
                  - 4.0 * X**2 * Functions_On_Float.Cos (X**2),
            "YAA Example usage test failed: second order derivative");
      end;

   end Test_Sample;

   procedure Test_Gradient (Object : in out Test) is
      package YAA_F is new YAA (Real => Float);
      package YAA_Functions_F is new YAA_F.Functions;
      use YAA_F.Real_Arrays;

      package Functions_On_Float is new
         Ada.Numerics.Generic_Elementary_Functions (Float);
      use Functions_On_Float;

      generic
         type T is private;
         type ArrayT is array (Positive range <>) of T;
         with function "*" (X : T; Y : T) return T;
         with function "+" (X : T; Y : T) return T;
         with function To_T (X : Float) return T;
         with function ExpT (X : T) return T;
         with function SinT (X : T) return T;
      function F (Args : ArrayT) return T;

      function F (Args : ArrayT) return T is
      begin
         --  f(X, Y, Z)     = X * Exp(Y * sin(Z) + 2)
         --  df(X, Y, Z)/dX = Exp(Y * sin(Z) + 2)
         --  df(X, Y, Z)/dY = X * Exp(Y * sin(Z) + 2) * sin(Z)
         --  df(X, Y, Z)/dZ = X * Exp(Y * sin(Z) + 2) * Y * cos(Z)
         return Args (1) * ExpT (Args (2) * SinT (Args (3)) + To_T (2.0));
      end F;

      type FGenericDualArray is array (Positive range <>)
         of YAA_F.Dual_Types.Dual;
      type FGenericRealArray is array (Positive range <>) of Float;

      function F_Dual is new F (
         T => YAA_F.Dual_Types.Dual,
         ArrayT => FGenericDualArray,
         "*" => YAA_F.Dual_Types."*",
         "+" => YAA_F.Dual_Types."+",
         To_T => YAA_F.Dual_Types.To_Dual,
         ExpT => YAA_Functions_F.Exp,
         SinT => YAA_Functions_F.Sin);

      function GradientF is new YAA_F.Gradient (
         ArrayT => FGenericDualArray,
         RealArrayT => FGenericRealArray);

      function Distance (
         V1, V2 : YAA_F.Real_Arrays.Real_Vector) return Float is
         R : Float := 0.0;
         Diff : constant YAA_F.Real_Arrays.Real_Vector := V1 - V2;
      begin
         for I in Diff'Range loop
            R := (Diff (I)) ** 2;
         end loop;
         return R;
      end Distance;

   begin
      declare
         X : constant Float := 3.0;
         Y : constant Float := -1.0;
         Z : constant Float := 2.0;
         Args : constant FGenericRealArray := (X, Y, Z);
         ExpectedGradient : constant YAA_F.Real_Arrays.Real_Vector (1 .. 3) :=
            (
               Exp (Y * Sin (Z) + 2.0),
               X * Sin (Z) * Exp (Y * Sin (Z) + 2.0),
               X * Y * Cos (Z) * Exp (Y * Sin (Z) + 2.0)
            );
         ActualGradient : constant YAA_F.Real_Arrays.Real_Vector (1 .. 3) :=
            GradientF (F_Dual'Access, Args);
      begin

         Assert (
            Distance(ActualGradient, ExpectedGradient) < 1.0e-10,
            "YAA Example usage test failed: gradient");
      end;

   end Test_Gradient;

end Test_Yaa;
