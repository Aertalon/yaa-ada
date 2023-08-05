with AUnit.Assertions;
with AUnit.Test_Caller;

with Generic_Dual_Types;

package body Test_Duals is

   use AUnit.Assertions;

   package Caller is new AUnit.Test_Caller (Test);

   Test_Suite : aliased AUnit.Test_Suites.Test_Suite;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Name : constant String := "(Dual numbers test) ";
   begin
      Test_Suite.Add_Test (Caller.Create
         (Name & "Set and get", Test_Set_Get'Access));
      Test_Suite.Add_Test (Caller.Create
         (Name & "Inverse", Test_Inverse'Access));
      Test_Suite.Add_Test (Caller.Create
         (Name & "Addition", Test_Addition'Access));
      Test_Suite.Add_Test (Caller.Create
         (Name & "Subtraction", Test_Subtraction'Access));
      Test_Suite.Add_Test (Caller.Create
         (Name & "Multiplication", Test_Multiplication'Access));
      Test_Suite.Add_Test (Caller.Create
         (Name & "Scalar Multiplication", Test_Scalar_Multiplication'Access));
      Test_Suite.Add_Test (Caller.Create
         (Name & "Division", Test_Division'Access));

      Test_Suite.Add_Test (Caller.Create
         (Name & "To dual", Test_To_Dual'Access));
      Test_Suite.Add_Test (Caller.Create
         (Name & "Image", Test_Image'Access));

      return Test_Suite'Access;
   end Suite;

   procedure Test_Set_Get (Object : in out Test) is
      package Dual_Types_F is new Generic_Dual_Types (Real => Float);
      use Dual_Types_F;

      V : Dual := (1.0, 2.0, 3.0, 4.0);
   begin
      Assert (V.Re = 1.0, "Init re failed");
      Assert (V.Im1 = 2.0, "Init e1 failed");
      Assert (V.Im2 = 3.0, "Init e2 failed");
      Assert (V.Im12 = 4.0, "Init e12 failed");

      Set_Re (V, 10.0);
      Set_Im1 (V, 20.0);
      Set_Im2 (V, 30.0);
      Set_Im12 (V, 40.0);

      Assert (V.Re = 10.0, "Set re failed");
      Assert (V.Im1 = 20.0, "Set e1 failed");
      Assert (V.Im2 = 30.0, "Set e2 failed");
      Assert (V.Im12 = 40.0, "Set e12 failed");

   end Test_Set_Get;

   procedure Test_Inverse (Object : in out Test) is
      package Dual_Types_F is new Generic_Dual_Types (Real => Float);
      use Dual_Types_F;

      V : constant Dual := (1.0, 2.0, 3.0, 4.0);
      InvV : constant Dual := -V;
      ExpectedInvV : constant Dual := (-1.0, -2.0, -3.0, -4.0);
   begin
      Assert (InvV = ExpectedInvV, "Inverse failed");
   end Test_Inverse;

   procedure Test_Addition (Object : in out Test) is
      package Dual_Types_F is new Generic_Dual_Types (Real => Float);
      use Dual_Types_F;

      V1 : constant Dual := (1.0, 2.0, 3.0, 4.0);
      V2 : constant Dual := (10.0, 20.0, 30.0, 40.0);

      SumV1V2 : constant Dual := V1 + V2;
      ExpectedSumV1V2 : constant Dual := (11.0, 22.0, 33.0, 44.0);
   begin
      Assert (SumV1V2 = ExpectedSumV1V2, "Addition failed");
      Assert (V1 + (-V1) = Dual_Zero, "Addition failed");
   end Test_Addition;

   procedure Test_Subtraction (Object : in out Test) is
      package Dual_Types_F is new Generic_Dual_Types (Real => Float);
      use Dual_Types_F;

      V1 : constant Dual := (1.0, 2.0, 3.0, 4.0);
      V2 : constant Dual := (10.0, 20.0, 30.0, 40.0);

      DifferenceV1V2 : constant Dual := V1 - V2;
      ExpectedDifferenceV1V2 : constant Dual := (-9.0, -18.0, -27.0, -36.0);
   begin
      Assert (DifferenceV1V2 = ExpectedDifferenceV1V2, "Subtraction failed");
      Assert (DifferenceV1V2 = V1 + (-V2), "Subtraction failed");
      Assert (V1 - V1 = Dual_Zero, "Subtraction failed");
   end Test_Subtraction;

   procedure Test_Multiplication (Object : in out Test) is
      package Dual_Types_F is new Generic_Dual_Types (Real => Float);
      use Dual_Types_F;

      V1 : constant Dual := (1.0, 0.0, 2.0, 0.0);
      V2 : constant Dual := (-1.0, 1.0, 0.0, -20.0);

      MultiplicationV1V2 : constant Dual := V1 * V2;
      ExpectedMultiplicationV1V2 : constant Dual := (
         -1.0, 1.0, -2.0, -18.0);
   begin
      Assert (MultiplicationV1V2 = ExpectedMultiplicationV1V2,
         "Multiplication failed");
   end Test_Multiplication;

   procedure Test_Scalar_Multiplication (Object : in out Test) is
      package Dual_Types_F is new Generic_Dual_Types (Real => Float);
      use Dual_Types_F;

      V : constant Dual := (1.0, 2.0, 3.0, 4.0);
      R : constant Float := 5.0;

      ScalarMultiplicationVR : constant Dual := V * R;
      ScalarMultiplicationRV : constant Dual := R * V;

      ExpectedMultiplicationVR : constant Dual := (
         5.0, 10.0, 15.0, 20.0);
   begin
      Assert (ScalarMultiplicationVR = ExpectedMultiplicationVR,
         "Scalar multiplication failed");
      Assert (ScalarMultiplicationRV = ExpectedMultiplicationVR,
         "Scalar multiplication failed");
   end Test_Scalar_Multiplication;

   procedure Test_Division (Object : in out Test) is
      package Dual_Types_F is new Generic_Dual_Types (Real => Float);
      use Dual_Types_F;

      V1 : constant Dual := (1.0, 2.0, 3.0, 4.0);
      V2 : constant Dual := (-1.0, 5.0, -2.0, 4.0);

      DivisionV1V2 : constant Dual := V1 / V2;

   begin
      Assert (
         DivisionV1V2 * V2 = V1,
         "Ratio times denominator is numerator failed");
      Assert (V1 / V1 = Dual_One, "Division by itself failed");
   end Test_Division;

   procedure Test_To_Dual (Object : in out Test) is
      package Dual_Types_F is new Generic_Dual_Types (Real => Float);
      use Dual_Types_F;

      R : constant Float := -5.0;
      D : constant Dual := To_Dual (R);

      ExpectedD : constant Dual := (-5.0, 0.0, 0.0, 0.0);
   begin
      Assert (ExpectedD = D, "To dual failed");
   end Test_To_Dual;

   procedure Test_Image (Object : in out Test) is
      package Dual_Types_F is new Generic_Dual_Types (Real => Float);
      use Dual_Types_F;

      D : constant Dual := (1.0, 2.0, 3.0, 4.0);
      ExpectedString : constant String :=
         "( 1.00000E+00,  2.00000E+00,  3.00000E+00,  4.00000E+00)";

   begin
      Assert (Image (D) = ExpectedString, "Image failed");
   end Test_Image;

end Test_Duals;
