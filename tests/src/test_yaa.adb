with Ada.Numerics.Generic_Elementary_Functions;

with AUnit.Assertions;
with AUnit.Test_Caller;

with YAA;
with YAA.Functions;
with Generic_Dual_Types;

package body Test_Yaa is

   use AUnit.Assertions;

   package Caller is new AUnit.Test_Caller (Test);

   Test_Suite : aliased AUnit.Test_Suites.Test_Suite;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Name : constant String := "(Dual numbers test) ";
   begin
      Test_Suite.Add_Test (Caller.Create
         (Name & "Sample", Test_Sample'Access));

      return Test_Suite'Access;
   end Suite;

   procedure Test_Sample (Object : in out Test) is
      package YAA_F is new YAA (Real => Float);
      package YAA_Functions_F is new YAA_F.Functions (Real => Float);
      use YAA_Functions_F;

      package Dual_Types_F is new Generic_Dual_Types (Real => Float);
      use Dual_Types_F;
      package Functions_On_Float is new
         Ada.Numerics.Generic_Elementary_Functions (Float);

      generic
         type T is private;
         with function "*" (X : T; Y : T) return T;
      function F (X : T) return T;

      function F (X : T) return T is
      begin
         return Cos (X * X);
      end F;

      function F_Dual is new F (
         T => Dual_Types_F.Dual,
         "*" => Dual_Types_F."*");

   begin
      Assert (
         YAA_F.Derivative (F_Dual'Access, 4.0) =
            -4.0 * Functions_On_Float.Sin (4.0),
         "Sample test failed");
   end Test_Sample;

end Test_Yaa;
