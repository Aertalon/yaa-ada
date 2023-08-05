with AUnit.Test_Suites;
with AUnit.Test_Fixtures;

package Test_Duals is

   function Suite return AUnit.Test_Suites.Access_Test_Suite;

private

   type Test is new AUnit.Test_Fixtures.Test_Fixture with null record;

   --  Set and get tests
   procedure Test_Set_Get (Object : in out Test);

   --  Operations
   procedure Test_Inverse (Object : in out Test);
   procedure Test_Addition (Object : in out Test);
   procedure Test_Subtraction (Object : in out Test);
   procedure Test_Multiplication (Object : in out Test);
   procedure Test_Scalar_Multiplication (Object : in out Test);
   procedure Test_Division (Object : in out Test);

   --  Utils
   procedure Test_To_Dual (Object : in out Test);
   procedure Test_Image (Object : in out Test);

end Test_Duals;
