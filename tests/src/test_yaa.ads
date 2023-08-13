with AUnit.Test_Suites;
with AUnit.Test_Fixtures;

package Test_Yaa is

   function Suite return AUnit.Test_Suites.Access_Test_Suite;

private

   type Test is new AUnit.Test_Fixtures.Test_Fixture with null record;

   --  Sample usage
   procedure Test_Sample (Object : in out Test);

   --  Gradient and Hessian sample usage
   procedure Test_Gradient_Hessian (Object : in out Test);

end Test_Yaa;
